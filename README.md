# PHPNuxbill bKash Payment Gateway with Sandbox and Live Environment Selection

## Overview

This PHPNuxbill plugin integrates the **bKash** payment gateway, enabling merchants to accept payments via bKash. The plugin supports both sandbox and live environments, making it ideal for testing and production use.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Payment Flow](#payment-flow)
- [Handling Responses](#handling-responses)
- [License](#license)
- [Contributing](#contributing)
- [Special Thanks](#special-thanks)

## Features

- **User-Friendly Interface**: Simple configuration options within the PHPNuxbill admin panel.
- **Environment Support**: Ability to switch between sandbox (for testing) and live (for real transactions).
- **Comprehensive Configuration**: Set your bKash APP Key, APP Secret, Username, and Password easily.
- **Payment Tracking**: Supports callbacks for success, failure, and cancellation scenarios.
- **Response Display**: Provides a formatted display of transaction details with the option to copy to clipboard.
- **Secure Transactions**: Utilizes bKash's API for secure payment processing.

## Requirements

- **PHP Version**: 7.1 or higher
- **PHP Extensions**: 
  - cURL
- **PHPNuxbill**: Ensure you have the latest version of PHPNuxbill installed.

## Installation

1. **Download or clone the Plugin**: Download the plugin files from this repository.
      ```bash
   git clone https://github.com/taukir007/BkashGateway-Phpnuxbill.git

2. **Upload Files**:
   - Copy `bkash.php` to the folder `system/paymentgateway/` in your PHPNuxbill installation.
   - Copy `ui/bkash.tpl` to the folder `system/paymentgateway/ui/`.

3. **Activate the Plugin**: 
   - After uploading, go to the PHPNuxbill admin panel, navigate to the Payment Gateway section, and activate the bKash payment plugin.

4. **Configuration**: Once activated, proceed to configure the plugin as described in the [Configuration](#configuration) section.


## Configuration

1. **Navigate to bKash Settings**: Once the plugin is activated, go to **Settings > Payment Gateways > bKash**.
   
2. **Configure bKash Credentials**: Enter your bKash APP Key, APP Secret, Username, and Password.

3. **Select Environment**: Choose between `sandbox` or `live` depending on your usage.

4. **Save Settings**: Click on the save button to store your bKash settings.

## Usage

1. **Initiate a Payment**: When a customer selects bKash as the payment method during checkout, they will be redirected to the bKash gateway to complete the transaction.

2. **Callback Handling**: Upon successful payment, the plugin will handle the response and update the order status.

## Payment Flow

- **Customer Checkout**: Customer chooses bKash as the payment option.
- **Redirect to bKash**: The plugin redirects the customer to the bKash payment gateway.
- **Payment Execution**: Customer completes the payment.
- **Callback**: The plugin handles the success, failure, or cancellation callback from bKash.

## Handling Responses

- **Success**: The order status will be updated as paid, and the payment details will be stored.
- **Failure**: If the transaction fails, the customer is notified, and the order status is updated accordingly.
- **Cancel**: If the payment is canceled, the plugin will update the status and notify the user.

## License

This plugin is open-source software licensed under the [MIT License](LICENSE).

## Contributing

If you'd like to contribute to this project, feel free to submit a pull request or raise an issue for discussion.

## Special Thanks

This plugin is an updated and modified version of the bKash payment integration plugin originally developed by:

- [hotspotbilling/phpnuxbill-bkash](https://github.com/hotspotbilling/phpnuxbill-bkash)
- [hotspotbilling/phpnuxbill](https://github.com/hotspotbilling/phpnuxbill)

Special thanks to the developers of these plugins for providing the foundation for this project.
