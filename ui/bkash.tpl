{include file="sections/header.tpl"}

<style>
    /* Clean Professional Theme 
       Colors: bKash Pink (#E2136E), White (#FFF), Light Gray (#F9F9F9)
    */

    /* Card Layout */
    .pro-card {
        background: #fff;
        border: none;
        border-radius: 8px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        margin-top: 20px;
    }

    .pro-header {
        background: #fff;
        padding: 25px 30px;
        border-bottom: 2px solid #f0f0f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
    }
    
    /* Top Accent Line */
    .pro-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: #E2136E; /* bKash Brand Color */
    }

    .pro-title {
        font-family: 'Segoe UI', sans-serif;
        font-weight: 700;
        font-size: 1.3rem;
        color: #333;
        margin: 0;
    }

    .pro-body {
        padding: 30px;
        background: #fdfdfd;
    }

    /* Input Styling */
    .form-group label {
        color: #555;
        font-weight: 600;
        font-size: 0.9rem;
        margin-bottom: 8px;
        display: block;
    }

    .clean-input-group {
        display: flex;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        background: #fff;
        transition: border-color 0.2s, box-shadow 0.2s;
        overflow: hidden;
    }

    .clean-input-group:focus-within {
        border-color: #E2136E;
        box-shadow: 0 0 0 3px rgba(226, 19, 110, 0.1);
    }

    .clean-addon {
        background: #f8f8f8;
        color: #888;
        padding: 12px 16px;
        border-right: 1px solid #e0e0e0;
        font-size: 1rem;
    }
    
    .clean-input {
        border: none;
        width: 100%;
        padding: 12px 15px;
        font-size: 1rem;
        color: #333;
        outline: none;
        background: transparent;
    }

    /* Select Dropdown */
    .clean-select {
        cursor: pointer;
        background: #fff;
    }

    /* Terminal Box */
    .code-box {
        background: #23241f;
        color: #f8f8f2;
        border-radius: 6px;
        padding: 15px;
        font-family: 'Consolas', 'Monaco', monospace;
        font-size: 0.85rem;
        line-height: 1.5;
        border: 1px solid #ddd;
    }

    /* Save Button */
    .btn-pro {
        background: #E2136E;
        color: #fff;
        border: none;
        padding: 12px 30px;
        border-radius: 4px;
        font-weight: 600;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        font-size: 0.9rem;
        transition: background 0.2s;
    }

    .btn-pro:hover {
        background: #c30f5d;
        color: #fff;
        box-shadow: 0 4px 12px rgba(226, 19, 110, 0.2);
    }

    /* Credits */
    .credits-bar {
        text-align: center;
        padding: 20px;
        color: #888;
        font-size: 0.85rem;
        background: #f9f9f9;
        border-top: 1px solid #eee;
    }
    
    .credits-bar a {
        color: #E2136E;
        font-weight: 700;
        text-decoration: none;
    }
    
    .credits-bar a:hover {
        text-decoration: underline;
    }

    .badge-env {
        font-size: 0.75rem;
        padding: 4px 8px;
        border-radius: 4px;
        font-weight: 600;
        text-transform: uppercase;
    }
    .badge-live { background: #E2136E; color: white; }
    .badge-sb { background: #6c757d; color: white; }

</style>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <form class="form-horizontal" method="post" autocomplete="off" role="form" action="{$_url}paymentgateway/bkash">
            
            <div class="pro-card">
                <div class="pro-header">
                    <h3 class="pro-title">
                        <i class="fa fa-sliders"></i> bKash Configuration
                    </h3>
                    <div>
                        {if $_c['bkash_env'] eq 'Live'}
                            <span class="badge-env badge-live">LIVE MODE</span>
                        {else}
                            <span class="badge-env badge-sb">SANDBOX</span>
                        {/if}
                    </div>
                </div>

                <div class="pro-body">
                    
                    <div class="form-group">
                        <label class="col-md-3 control-label">Environment</label>
                        <div class="col-md-9">
                            <div class="clean-input-group">
                                <div class="clean-addon"><i class="fa fa-server"></i></div>
                                <select class="clean-input clean-select" name="bkash_env">
                                    <option value="Live" {if $_c['bkash_env'] eq 'Live'}selected{/if}>Live Production (Real Money)</option>
                                    <option value="Sandbox" {if $_c['bkash_env'] eq 'Sandbox'}selected{/if}>Sandbox (Developer Test)</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div style="border-bottom: 1px dashed #ddd; margin: 25px 0;"></div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">App Key</label>
                        <div class="col-md-9">
                            <div class="clean-input-group">
                                <div class="clean-addon"><i class="fa fa-key"></i></div>
                                <input type="text" class="clean-input" name="bkash_app_key" value="{$_c['bkash_app_key']}" placeholder="Enter App Key">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">App Secret</label>
                        <div class="col-md-9">
                            <div class="clean-input-group">
                                <div class="clean-addon"><i class="fa fa-lock"></i></div>
                                <input type="password" class="clean-input" name="bkash_app_secret" value="{$_c['bkash_app_secret']}" placeholder="Enter App Secret">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">Username</label>
                        <div class="col-md-9">
                            <div class="clean-input-group">
                                <div class="clean-addon"><i class="fa fa-user"></i></div>
                                <input type="text" class="clean-input" name="bkash_username" value="{$_c['bkash_username']}" placeholder="Merchant Username">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">Password</label>
                        <div class="col-md-9">
                            <div class="clean-input-group">
                                <div class="clean-addon"><i class="fa fa-asterisk"></i></div>
                                <input type="password" class="clean-input" name="bkash_password" value="{$_c['bkash_password']}" placeholder="Merchant Password">
                            </div>
                        </div>
                    </div>

                    <div style="border-bottom: 1px dashed #ddd; margin: 25px 0;"></div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">Callback URL</label>
                        <div class="col-md-9">
                            <div class="clean-input-group" style="background: #f2f2f2;">
                                <div class="clean-addon"><i class="fa fa-link"></i></div>
                                <input type="text" readonly class="clean-input" onclick="this.select()" value="{$_url}callback/bkash" style="cursor: pointer; color: #E2136E; font-weight: 500;">
                            </div>
                            <p class="help-block" style="font-size: 0.8rem; margin-top: 5px;">Copy and paste this into your bKash Developer Console.</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">Walled Garden</label>
                        <div class="col-md-9">
                            <div class="code-box">
/ip hotspot walled-garden<br>
add dst-host=bkash.com<br>
add dst-host=*.bkash.com<br>
add dst-host=*.bka.sh
                            </div>
                            <p class="help-block" style="font-size: 0.8rem;">Run these commands in your MikroTik Terminal.</p>
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 30px; margin-bottom: 0;">
                        <div class="col-md-12 text-right">
                            <button class="btn-pro" type="submit">
                                <i class="fa fa-check"></i> Save Changes
                            </button>
                        </div>
                    </div>

                </div>

                <div class="credits-bar">
                    bKash Payment Gateway | Developed by <a href="https://github.com/taukir007" target="_blank">Taukir Ahmed</a>
                </div>

            </div>
        </form>
    </div>
</div>

{include file="sections/footer.tpl"}
