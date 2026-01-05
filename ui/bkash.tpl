{include file="sections/header.tpl"}

<style>
    /* ------------------------------------------------------------------
       THEME VARIABLES
       ------------------------------------------------------------------ */
    :root {
        --page-bg: #f8fafc;
        --card-bg: #ffffff;
        --border-color: #e2e8f0;
        
        --text-dark: #0f172a;
        --text-gray: #64748b;
        --text-light: #94a3b8;
        
        --brand-color: #6366f1; /* Indigo */
        --brand-hover: #4f46e5;
        
        --input-bg: #ffffff;
        --input-border: #cbd5e1;
        --input-focus: #6366f1;
        
        --code-bg: #1e293b;
        --code-text: #e2e8f0;
    }

    .dark-mode, .dark, [data-theme="dark"] {
        --page-bg: #0f172a;
        --card-bg: #1e293b;
        --border-color: #334155;
        --text-dark: #f8fafc;
        --text-gray: #cbd5e1;
        --text-light: #64748b;
        --input-bg: #0f172a;
        --input-border: #475569;
    }

    /* ------------------------------------------------------------------
       LAYOUT
       ------------------------------------------------------------------ */
    .config-wrapper {
        background-color: var(--page-bg);
        min-height: 100vh;
        padding: 40px 20px;
        font-family: 'Inter', system-ui, sans-serif;
    }

    .config-container {
        max-width: 800px;
        margin: 0 auto;
    }

    /* Header & Nav */
    .nav-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }

    .nav-title {
        font-size: 1.5rem;
        font-weight: 800;
        color: var(--text-dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .btn-back-outline {
        padding: 10px 20px;
        border: 1px solid var(--border-color);
        background: var(--card-bg);
        color: var(--text-gray);
        border-radius: 50px;
        font-weight: 600;
        font-size: 0.9rem;
        text-decoration: none !important;
        transition: all 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .btn-back-outline:hover {
        border-color: var(--brand-color);
        color: var(--brand-color);
        transform: translateX(-2px);
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.1);
    }

    /* ------------------------------------------------------------------
       MAIN CARD
       ------------------------------------------------------------------ */
    .config-card {
        background: var(--card-bg);
        border-radius: 16px;
        box-shadow: 0 4px 20px -5px rgba(0,0,0,0.05);
        border: 1px solid var(--border-color);
        overflow: hidden;
        position: relative;
    }

    /* Top Accent Line */
    .config-card::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--brand-color), #8b5cf6);
    }

    .card-header {
        padding: 25px 30px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .header-title {
        font-size: 1.1rem;
        font-weight: 700;
        color: var(--text-dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .header-title i { color: var(--brand-color); }

    /* Environment Badge */
    .env-badge {
        font-size: 0.75rem;
        padding: 5px 10px;
        border-radius: 6px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .badge-live { background: rgba(16, 185, 129, 0.1); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.2); }
    .badge-sb { background: rgba(245, 158, 11, 0.1); color: #f59e0b; border: 1px solid rgba(245, 158, 11, 0.2); }

    .card-body {
        padding: 30px;
    }

    /* Form Styles */
    .form-group {
        margin-bottom: 25px;
    }

    .form-label {
        display: block;
        color: var(--text-dark);
        font-weight: 600;
        font-size: 0.9rem;
        margin-bottom: 8px;
    }

    .input-wrapper {
        display: flex;
        align-items: center;
        border: 1px solid var(--input-border);
        background: var(--input-bg);
        border-radius: 8px;
        overflow: hidden;
        transition: all 0.2s;
    }

    .input-wrapper:focus-within {
        border-color: var(--brand-color);
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }

    .input-icon {
        padding: 12px 16px;
        color: var(--text-light);
        border-right: 1px solid var(--border-color);
        background: rgba(0,0,0,0.01);
        font-size: 1rem;
    }

    .form-input {
        flex: 1;
        border: none;
        background: transparent;
        padding: 12px 15px;
        font-size: 0.95rem;
        color: var(--text-dark);
        outline: none;
        width: 100%;
    }

    .form-select {
        flex: 1;
        border: none;
        background: transparent;
        padding: 12px 15px;
        font-size: 0.95rem;
        color: var(--text-dark);
        outline: none;
        cursor: pointer;
    }

    /* Code Block */
    .code-block {
        background: var(--code-bg);
        color: var(--code-text);
        padding: 15px;
        border-radius: 8px;
        font-family: 'SF Mono', 'Consolas', monospace;
        font-size: 0.85rem;
        line-height: 1.6;
        border: 1px solid var(--border-color);
    }

    .help-text {
        color: var(--text-gray);
        font-size: 0.85rem;
        margin-top: 8px;
    }

    /* Divider */
    .divider {
        height: 1px;
        background: var(--border-color);
        margin: 30px 0;
        border: none;
    }

    /* Footer Actions */
    .card-footer {
        padding: 20px 30px;
        background: rgba(0,0,0,0.01);
        border-top: 1px solid var(--border-color);
        display: flex;
        justify-content: flex-end;
    }

    .btn-save {
        background: var(--brand-color);
        color: #fff;
        border: none;
        padding: 12px 32px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-save:hover {
        background: var(--brand-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
    }

    /* Credits */
    .credits {
        text-align: center;
        margin-top: 30px;
        color: var(--text-light);
        font-size: 0.85rem;
    }
    .credits a {
        color: var(--brand-color);
        text-decoration: none;
        font-weight: 600;
    }

</style>

<div class="config-wrapper">
    <div class="config-container">

        <div class="nav-header">
            <h1 class="nav-title">
                Configure Gateway
            </h1>
            <a href="{Text::url('paymentgateway')}" class="btn-back-outline">
                <i class="fa fa-arrow-left"></i> Back to List
            </a>
        </div>

        <form class="form-horizontal" method="post" autocomplete="off" role="form" action="{$_url}paymentgateway/bkash">
            
            <div class="config-card">
                
                <div class="card-header">
                    <div class="header-title">
                        <i class="fa fa-cogs"></i> bKash Settings
                    </div>
                    <div>
                        {if $_c['bkash_env'] eq 'Live'}
                            <span class="env-badge badge-live">Live Mode</span>
                        {else}
                            <span class="env-badge badge-sb">Sandbox</span>
                        {/if}
                    </div>
                </div>

                <div class="card-body">

                    <div class="form-group">
                        <label class="form-label">Environment Mode</label>
                        <div class="input-wrapper">
                            <div class="input-icon"><i class="fa fa-server"></i></div>
                            <select class="form-select" name="bkash_env">
                                <option value="Live" {if $_c['bkash_env'] eq 'Live'}selected{/if}>Live Production (Real Money)</option>
                                <option value="Sandbox" {if $_c['bkash_env'] eq 'Sandbox'}selected{/if}>Sandbox (Developer Test)</option>
                            </select>
                        </div>
                        <p class="help-text">Select 'Sandbox' for testing or 'Live' to accept real payments.</p>
                    </div>

                    <hr class="divider">

                    <div class="form-group">
                        <label class="form-label">App Key</label>
                        <div class="input-wrapper">
                            <div class="input-icon"><i class="fa fa-key"></i></div>
                            <input type="text" class="form-input" name="bkash_app_key" value="{$_c['bkash_app_key']}" placeholder="Enter App Key">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">App Secret</label>
                        <div class="input-wrapper">
                            <div class="input-icon"><i class="fa fa-lock"></i></div>
                            <input type="password" class="form-input" name="bkash_app_secret" value="{$_c['bkash_app_secret']}" placeholder="Enter App Secret">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <div class="input-wrapper">
                            <div class="input-icon"><i class="fa fa-user"></i></div>
                            <input type="text" class="form-input" name="bkash_username" value="{$_c['bkash_username']}" placeholder="Merchant Username">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div class="input-wrapper">
                            <div class="input-icon"><i class="fa fa-asterisk"></i></div>
                            <input type="password" class="form-input" name="bkash_password" value="{$_c['bkash_password']}" placeholder="Merchant Password">
                        </div>
                    </div>

                    <hr class="divider">

                    <div class="form-group">
                        <label class="form-label">Callback URL</label>
                        <div class="input-wrapper" style="background: rgba(99, 102, 241, 0.05); border-color: rgba(99, 102, 241, 0.2);">
                            <div class="input-icon" style="color: var(--brand-color);"><i class="fa fa-link"></i></div>
                            <input type="text" readonly class="form-input" onclick="this.select()" value="{$_url}callback/bkash" style="cursor: pointer; color: var(--brand-color); font-weight: 600;">
                        </div>
                        <p class="help-text">Copy and paste this URL into your bKash Developer Console.</p>
                    </div>

                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label">Walled Garden (MikroTik)</label>
                        <div class="code-block">
                            /ip hotspot walled-garden<br>
                            add dst-host=bkash.com<br>
                            add dst-host=*.bkash.com<br>
                            add dst-host=*.bka.sh
                        </div>
                        <p class="help-text">Run these commands in your MikroTik Terminal to allow access for unpaid users.</p>
                    </div>

                </div>

                <div class="card-footer">
                    <button class="btn-save" type="submit">
                        <i class="fa fa-check-circle"></i> Save Changes
                    </button>
                </div>

            </div>
        </form>

        <div class="credits">
            bKash Payment Gateway &bull; Developed by <a href="https://github.com/taukir007" target="_blank">Taukir Ahmed</a>
        </div>

    </div>
</div>

{include file="sections/footer.tpl"}
