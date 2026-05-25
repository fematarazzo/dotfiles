// user.js — firefox hardening that doesn't break the web
// drop into ~/.mozilla/firefox/<profile>/user.js

// ── telemetry off ──────────────────────────────────────
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// ── pocket off ─────────────────────────────────────────
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.showHome", false);

// ── clean new tab ──────────────────────────────────────
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);

// ── studies / experiments off ──────────────────────────
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// ── search ─────────────────────────────────────────────
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.trimURLs", false);

// ── privacy ────────────────────────────────────────────
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.resistFingerprinting", false);   // breaks too many sites
user_pref("network.cookie.cookieBehavior", 5);      // total cookie protection
user_pref("network.http.referer.XOriginPolicy", 1); // referer only same origin
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

// ── webrtc IP leak protection ──────────────────────────
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);

// ── DNS-over-HTTPS (mullvad, not cloudflare) ───────────
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://dns.mullvad.net/dns-query");

// ── HTTPS-only ─────────────────────────────────────────
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// ── ui ─────────────────────────────────────────────────
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.startup.page", 3);               // restore previous session
user_pref("browser.download.useDownloadDir", false);  // ask where to save
user_pref("browser.aboutConfig.showWarning", false);
