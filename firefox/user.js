// Printer Settings Default off
user_pref("print.print_footerleft", "");
user_pref("print.print_footerright", "");
user_pref("print.print_headerleft", "");
user_pref("print.print_headerright", "");

user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.tabClipWidth", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.vpn_promo.enabled", false);

// Zooooooom
user_pref("network.buffer.cache.size", 262144); // in bytes. 262144=256KB (You can also try 524288 [=512KB] to see if it works even better) / "the stream buffer segment size used for most network activity." (http://forums.mozillazine.org/viewtopic.php?f=7&t=2416193) / "the default setting is 32 kB, and that corresponds with the buffer size of very old TCP/IP stacks." (https://www.mail-archive.com/support-seamonkey@lists.mozilla.org/msg74561.html) (note "buffer.cache"="segment" https://bugzilla.mozilla.org/show_bug.cgi?id=715770#c1)
user_pref("network.buffer.cache.count", 128); // https://www.mail-archive.com/support-seamonkey@lists.mozilla.org/msg74561.html
user_pref("network.http.max-connections", 1800); // default=900
user_pref("network.http.max-connections-per-server", 32); // might not be used anymore, there's no result for it in searchfox.com (last default might have been 15) https://kb.mozillazine.org/Network.http.max-connections-per-server
user_pref("network.http.max-persistent-connections-per-server", 12); // default=6
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 10); // default=3. "Number of connections that we can open beyond the standard parallelism limit defined by max-persistent-connections-per-server/-proxy to handle urgent-start marked requests"
user_pref("network.http.pacing.requests.burst", 32); // default=10, controls how many HTTP requests are sent at once
user_pref("network.http.pacing.requests.min-parallelism", 10); // default=6. "Min-Parallelism is the amount of active connections that have to be in use in order for the rate limiter to be used" (https://bugzilla.mozilla.org/show_bug.cgi?id=819734#c1)
user_pref("network.websocket.max-connections", 400); // default=200. "Most communication between web browsers and web sites uses HTTP. With HTTP, the client sends a request and the server returns a response. Typically, the response occurs immediately, and the transaction is complete. Even if the network connection stays open, this will be used for a separate transaction of a request and a response. Some modern web sites use WebSockets. WebSocket connections are initiated over HTTP and are typically long-lived. Messages can be sent in either direction at any time and are not transactional in nature. The connection will normally stay open and idle until either the client or the server is ready to send a message."
user_pref("network.ssl_tokens_cache_capacity", 32768); // more TLS token caching (fast reconnects)
// also see "security.pki.crlite_mode" and "browser.cache.memory.capacity"


// Security
// user_pref("dom.security.https_only_mode", true); // "if HTTPS-Only Mode is enabled, then Firefox will upgrade all connections to HTTPS." / "When the top-level is HTTPS, insecure subresources are also upgraded (silent fail)"
user_pref("dom.security.https_only_mode_send_http_background_request", false); // disable HTTP background requests - When attempting to upgrade, if the server doesn't respond within 3 seconds, Firefox sends a top-level HTTP request without path in order to check if the server supports HTTPS or not. This is done to avoid waiting for a timeout which takes 90 seconds
user_pref("security.mixed_content.block_active_content", true); // disable insecure active content on https pages (mixed content) (might not be needed with HTTPS-Only Mode enabled)
user_pref("security.mixed_content.block_display_content", true); // disable insecure passive content (such as images) on https pages, "Parts of this page are not secure (such as images)"
user_pref("security.mixed_content.upgrade_display_content", true); // Try to load HTTP content as HTTPS (in mixed content pages)
user_pref("network.auth.subresource-http-auth-allow", 1); // limit (or disable) HTTP authentication credentials dialogs triggered by sub-resources. Hardens against potential credentials phishing
user_pref("browser.xul.error_pages.expert_bad_cert", true); // display advanced information on Insecure Connection warning pages
user_pref("security.dialog_enable_delay", 700); // enforce a security delay on some confirmation dialogs such as install, open/save
user_pref("security.insecure_field_warning.contextual.enabled", true); // Show in-content login form warning UI for insecure login fields
user_pref("security.insecure_password.ui.enabled", true); // show a warning that a login form is delivered via HTTP (a security risk)
user_pref("security.ssl.require_safe_negotiation", true); // Blocks connections to servers that don't support RFC 5746 as they're potentially vulnerable to a MiTM attack
user_pref("security.pki.crlite_mode", 2); // switching from OCSP to CRLite for checking sites certificates which has compression, is faster, and more private. 2="CRLite will enforce revocations in the CRLite filter, but still use OCSP if the CRLite filter does not indicate a revocation" (https://www.reddit.com/r/firefox/comments/wesya4/danger_of_disabling_query_ocsp_option_in_firefox/, https://blog.mozilla.org/security/2020/01/09/crlite-part-2-end-to-end-design/)
user_pref("security.cert_pinning.enforcement_level", 2); // 2=strict. Public key pinning prevents man-in-the-middle attacks due to rogue CAs [certificate authorities] not on the site's list

user_pref("full-screen-api.warning.timeout", 0);
