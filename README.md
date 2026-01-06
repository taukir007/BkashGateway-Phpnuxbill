# PHPNuxbill bKash Payment Gateway (Modern Edition)

> **Looking for advanced PHPNuxbill UI Customization? Visit the official customization repository here: [taukir007/NuxCustomization](https://github.com/taukir007/NuxCustomization)**

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/bn/thumb/a/a8/%E0%A6%AC%E0%A6%BF%E0%A6%95%E0%A6%BE%E0%A6%B6%E0%A7%87%E0%A6%B0_%E0%A6%B2%E0%A7%8B%E0%A6%97%E0%A7%8B.svg/960px-%E0%A6%AC%E0%A6%BF%E0%A6%95%E0%A6%BE%E0%A6%B6%E0%A7%87%E0%A6%B0_%E0%A6%B2%E0%A7%8B%E0%A6%97%E0%A7%8B.svg.png" width="200" alt="bKash Logo">
</p>

## Overview

This is a **completely redesigned** bKash payment gateway plugin for **PHPNuxbill**. It features a modern, professional user interface with a "Pro-Card" design, explicit Sandbox/Live environment switching, and visual status indicators. It enables merchants to seamlessly accept payments via bKash Tokenized API.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [MikroTik Setup](#mikrotik-setup-walled-garden)
- [Payment Flow](#payment-flow)
- [License](#license-------)
- [Credits](#credits)

## Features

* **Modern "Pro-Card" UI:** A clean, high-contrast, professional interface.
* **Live/Sandbox Toggle:** Dedicated dropdown to switch between `Sandbox` (Testing) and `Live` (Production) modes.
* **Visual Status Badge:** A dynamic badge in the header (Pink for LIVE, Grey for SANDBOX).
* **MikroTik Integration:** Built-in "Walled Garden" code generator.
* **Smart Inputs:** Clean input groups with icons and "click-to-copy" functionality.
* **Secure:** Uses the latest bKash Tokenized API.

## Requirements

* **PHPNuxbill**: Latest version installed.
* **PHP Version**: 7.2 or higher.
* **Extensions**: `curl`, `json`.
* **bKash Credentials**: Merchant Account (App Key, App Secret, Username, Password).

## Installation

1.  **Download/Clone the Plugin**:
    ```bash
    git clone https://github.com/taukir007/BkashGateway-NuX.git
    ```

2.  **Upload Files**:
    * Copy `bkash.php` to: `system/paymentgateway/`
    * Copy `bkash.tpl` to: `system/paymentgateway/ui/`

3.  **Activate**:
    * Login to Admin Panel -> **Settings** -> **Payment Gateway**.
    * Find **bKash** and click **Activate**.

## Configuration

1.  **Open Settings**: Go to **Settings > Payment Gateways > bKash**.
2.  **Select Environment**: Choose **Sandbox** or **Live**.
3.  **Enter Credentials**: Fill in App Key, App Secret, Username, and Password.
4.  **Setup Webhook**: Copy the **Callback URL** and paste it into your bKash Developer panel.
5.  **Save**: Click **Save Changes**.

## MikroTik Setup (Walled Garden)

Run these commands in your MikroTik Terminal to allow access for unpaid users:

```mikrotik
/ip hotspot walled-garden
add dst-host=bkash.com
add dst-host=*.bkash.com
add dst-host=*.bka.sh
```

## Payment Flow

* **Checkout:** Customer selects bKash at checkout.
* **Redirect:** Customer is redirected to the secure bKash payment page.
* **Verification:** Customer enters their bKash number, OTP, and PIN.
* **Completion:**
    * **Success:** Payment is verified, user is redirected back, and PHPNuxbill activates their plan automatically.
    * **Fail:** User is shown an error message.

## License   - [ ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg) ]

This project is licensed under the **MIT License**.

You are free to:
- Use the project for personal or commercial purposes
- Modify and customize the code
- Distribute and share it

See the [LICENSE](LICENSE) file for full license details.

## Credits

**Developed & Redesigned by:** Taukir Ahmed

**Original Core Logic based on:**
* hotspotbilling/phpnuxbill-bkash
* hotspotbilling/phpnuxbill
