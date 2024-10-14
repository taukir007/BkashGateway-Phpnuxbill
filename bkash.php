<?php

/**
 * PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *
 * Payment Gateway bkash.com
 *
 * By: Taukir Ahmed
 **/

function bkash_validate_config()
{
    global $config;
    if (empty($config['bkash_app_key']) || empty($config['bkash_app_secret']) || 
        empty($config['bkash_username']) || empty($config['bkash_password']) || 
        empty($config['bkash_environment'])) {
        sendTelegram("BKASH payment gateway not configured");
        r2(U . 'order/package', 'w', Lang::T("Admin has not yet setup BKASH payment gateway, please tell admin"));
    }
}

function bkash_show_config()
{
    global $ui, $config;
    $ui->assign('_title', 'bKash - Tokenizer - Payment Gateway By Taukir');
    $ui->assign('config', $config);  // Pass config variables to the template
    $ui->display('bkash.tpl');  // Display the bKash settings template
}

function bkash_save_config()
{
    global $admin;
    
    // Get POST values
    $bkash_app_key = _post('bkash_app_key');
    $bkash_app_secret = _post('bkash_app_secret');
    $bkash_username = _post('bkash_username');
    $bkash_password = _post('bkash_password');
    $bkash_environment = _post('bkash_environment');  // Save environment
    
    // Save bKash settings
    foreach (['bkash_app_key', 'bkash_app_secret', 'bkash_username', 'bkash_password', 'bkash_environment'] as $setting) {
        $d = ORM::for_table('tbl_appconfig')->where('setting', $setting)->find_one();
        if ($d) {
            $d->value = $$setting; // Variable variable for the setting
            $d->save();
        } else {
            $d = ORM::for_table('tbl_appconfig')->create();
            $d->setting = $setting;
            $d->value = $$setting;
            $d->save();
        }
    }

    // Log and redirect with success message
    _log('[' . $admin['username'] . ']: bKash ' . Lang::T('Settings_Saved_Successfully'), 'Admin', $admin['id']);
    r2(U . 'paymentgateway/bkash', 's', Lang::T('Settings_Saved_Successfully'));
}

function bkash_create_transaction($trx, $user)
{
    global $config;
    $json = [
        'intent' => 'sale',
        'mode' => '0011',
        'payerReference' => $trx['id'],
        'currency' => 'BDT',
        'amount' => $trx['price'],
        'callbackURL' => U . 'order/view/' . $trx['id'] . '/check',
        'merchantInvoiceNumber' => $trx['id'],
    ];
    $headers = [
        'Authorization: ' . bkash_get_token(),
        'X-App-Key: ' . $config['bkash_app_key']
    ];
    $result = json_decode(Http::postJsonData(bkash_get_server() . 'checkout/create', $json, $headers), true);
    
    if ($result['statusMessage'] != 'Successful') {
        sendTelegram("bKash payment failed\n\n" . json_encode($result, JSON_PRETTY_PRINT));
        r2(U . 'order/package', 'e', Lang::T("Failed to create transaction. " . $result['errorMessage']));
    }
    
    $d = ORM::for_table('tbl_payment_gateway')
        ->where('username', $user['username'])
        ->where('status', 1)
        ->find_one();
    $d->gateway_trx_id = $result['paymentID'];
    $d->pg_url_payment = $result['bkashURL'];
    $d->pg_request = json_encode($result);
    $d->expired_date = date('Y-m-d H:i:s', strtotime('+ 4 HOURS'));
    $d->save();
    
    header('Location: ' . $result['bkashURL']);
    exit();
}

function bkash_get_status($trx, $user)
{
    global $config;

    $maxRetries = 3;
    $retryDelay = 5; // Seconds between retries
    $statusChecked = false;

    for ($i = 0; $i < $maxRetries; $i++) {
        Http::postJsonData(bkash_get_server() . 'checkout/execute', ['paymentID' => $trx['gateway_trx_id']], [
            'Authorization: ' . bkash_get_token(), 
            'X-App-Key: ' . $config['bkash_app_key']
        ]);
        $result = json_decode(Http::postJsonData(bkash_get_server() . 'checkout/payment/status', ['paymentID' => $trx['gateway_trx_id']], [
            'Authorization: ' . bkash_get_token(), 
            'X-App-Key: ' . $config['bkash_app_key']
        ]), true);
        
        if ($result['statusCode'] == '0000') {
            $statusChecked = true;
            break;
        }

        // Wait before retrying
        sleep($retryDelay);
    }

    if (!$statusChecked) {
        sendTelegram("bKash payment status failed\n\n" . json_encode($result, JSON_PRETTY_PRINT));
        r2(U . "order/view/" . $trx['id'], 'e', Lang::T("Failed to check status transaction. " . $result['errorMessage']));
    }

    if ($trx['status'] == 2) {
        r2(U . "order/view/" . $trx['id'], 'd', Lang::T("Transaction has been paid.."));
    }
    
    if ($result['transactionStatus'] == 'Completed') {
        if (!Package::rechargeUser($user['id'], $trx['routers'], $trx['plan_id'], $trx['gateway'], 'bKash')) {
            r2(U . "order/view/" . $trx['id'], 'd', Lang::T("Failed to activate your Package, try again later."));
        }
        
        $trx->pg_paid_response = json_encode($result);
        $trx->payment_method = 'bKash';
        $trx->payment_channel = 'bKash';
        $trx->paid_date = date('Y-m-d H:i:s', $result['paid_at']);
        $trx->status = 2;
        $trx->save();

        r2(U . "order/view/" . $trx['id'], 's', Lang::T("Transaction has been paid."));
    } else {
        r2(U . "order/view/" . $trx['id'], 'w', Lang::T("Transaction still unpaid."));
    }
}

// Callback
// Callback
function bkash_payment_notification()
{
    global $config;

    if ($_GET['status'] == 'success') {
        $paymentID = $_GET['paymentID'];

        // Execute payment
        $paymentResponse = json_decode(Http::postJsonData(bkash_get_server() . 'checkout/execute', ['paymentID' => $paymentID], [
            'Authorization: ' . bkash_get_token(), 
            'X-App-Key: ' . $config['bkash_app_key']
        ]), true);

        // Store payment response in session
        $_SESSION['bkash_payment_response'] = $paymentResponse;

        // Redirect to success page or wherever you want to show the details
        header('Location: ' . U . 'order/view/' . $_GET['paymentID']);
        exit();
    } else {
        sendTelegram("BKASH payment " . $_GET['status'] . " for paymentID: " . $_GET['paymentID']);
    }
}


// Get bKash token for API requests
function bkash_get_token()
{
    global $config;
    $json = [
        'app_key' => $config['bkash_app_key'],
        'app_secret' => $config['bkash_app_secret']
    ];
    $url = bkash_get_server() . 'checkout/token/grant';
    $headers = [
        'username: ' . $config['bkash_username'], 
        'password: ' . $config['bkash_password']
    ];
    
    // Log the request data
    error_log("Requesting token: URL: $url, Headers: " . json_encode($headers) . ", Body: " . json_encode($json));

    $result = json_decode(Http::postJsonData($url, $json, $headers), true);
    if (empty($result['id_token'])) {
        error_log("Token generation failed: " . json_encode($result, JSON_PRETTY_PRINT));
        sendTelegram("Failed to retrieve bKash token\n\n" . json_encode($result, JSON_PRETTY_PRINT));
        r2(U . 'order/package', 'e', Lang::T("Failed to create bKash token"));
    }
    return $result['id_token'];
}

function bkash_get_server()
{
    global $config;
    return $config['bkash_environment'] == 'sandbox' ? 'https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/' : 'https://tokenized.pay.bka.sh/v1.2.0-beta/tokenized/';
}

