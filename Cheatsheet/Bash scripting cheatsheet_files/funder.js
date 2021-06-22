(function() {
  function embed () {
    var evt = new Event('codefund');
    var uplift = {};

    function trackUplift() {
      try {
        var url = 'https://codefund.app/impressions/3b69ae5a-8153-4299-8500-edc9613e24e4/uplift?advertiser_id=700';
        console.log('CodeFund is recording uplift. ' + url);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', url);
        xhr.send();
      } catch (e) {
        console.log('CodeFund was unable to record uplift! ' + e.message);
      }
    };

    function verifyUplift() {
      if (uplift.pixel1 === undefined || uplift.pixel2 === undefined) { return; }
      if (uplift.pixel1 && !uplift.pixel2) { trackUplift(); }
    }

    function detectUplift(count) {
      var url = 'https://cdn2.codefund.app/assets/px.js';
      if (url.length === 0) { return; }
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
          if (xhr.status >= 200 && xhr.status < 300) {
            if (count === 1) { detectUplift(2); }
            uplift['pixel' + count] = true;
          } else {
            uplift['pixel' + count] = false;
          }
          verifyUplift();
        }
      };
      xhr.open('GET', url + '?ch=' + count + '&rnd=' + Math.random() * 11);
      xhr.send();
    }

    function elementVisible(element) {
      if (!element) { return false; }

      while (element) {
        var style = getComputedStyle(element);
        if (style.visibility === 'hidden' || style.display === 'none') { return false; }
        element = element.parentElement;
      }

      return true;
    }

    function closeCodeFund() {
      var codeFundElement = document.getElementById('codefund') || document.getElementById('codefund_ad');
      codeFundElement.remove();
      sessionStorage.setItem('codefund', 'closed');
    }

    try {
      if (sessionStorage.getItem('codefund') === 'closed') { return; }

      var codeFundElement = document.getElementById('codefund') || document.getElementById('codefund_ad');
      if (!elementVisible(codeFundElement)) {
        console.log('CodeFund element not visible! Please verify an element exists with id="codefund" and that it is visible.');
        return;
      }

      codeFundElement.innerHTML = '<div id="cf"> <div class="cf-wrapper" style="max-width: 330px; display: block; font-size: 14px; line-height: 1.4; font-family: Helvetica, Arial; margin-left: auto; margin-right: auto; padding: 15px;" align="center"> <div class="cf-header" style="font-size: 12px; color: #678; display: block; margin-bottom: 8px;">Proudly sponsored by</div> <a data-href="campaign_url" class="cf-text" target="_blank" rel="sponsored noopener" style="box-shadow: none !important; color: #333; text-decoration: none;"> <strong>TeamCity</strong> <span>Continuous Integration and Deployment server out of the box. Free forever</span> </a> <a href="https://app.codefund.io" data-target="powered_by_url" class="cf-powered-by" target="_blank" rel="sponsored noopener" style="box-shadow: none !important; margin-top: 5px; font-size: 11px; display: block; color: #678; text-decoration: none; text-align: center;"> <em>ethical</em> ad by CodeFund <img data-src="impression_url" alt="" style="position: fixed; left: -1000px; top: -1000px;"> </a> </div> </div> <style>#cf .cf-header:before { content: " "; margin: 0 0.5em; opacity: 0.5; } #cf .cf-header:after { content: " "; margin: 0 0.5em; opacity: 0.5; } </style>';
      codeFundElement.querySelector('img[data-src="impression_url"]').src = 'https://codefund.app/display/3b69ae5a-8153-4299-8500-edc9613e24e4.gif';
      codeFundElement.querySelectorAll('a[data-href="campaign_url"]').forEach(function (a) { a.href = 'https://codefund.app/impressions/3b69ae5a-8153-4299-8500-edc9613e24e4/click?campaign_id=543&creative_id=409&property_id=51&template=centered&theme=light'; });

      var poweredByElement = codeFundElement.querySelector('a[data-target="powered_by_url"]');
      if (poweredByElement) { poweredByElement.href = 'https://codefund.app/invite/lN4RA92tcuA'; }

      var closeElement = codeFundElement.querySelector('button[data-behavior="close"]');
      if (closeElement) { closeElement.addEventListener('click', closeCodeFund); }

      evt.detail = { status: 'ok', house: false };
      detectUplift(1);
    } catch (e) {
      console.log('CodeFund detected an error! Please verify an element exists with id="codefund". ' + e.message);
      evt.detail = { status: 'error', message: e.message };
    }
    document.removeEventListener('DOMContentLoaded', embed);
    window.dispatchEvent(evt);
  };
  (document.readyState === 'loading') ? document.addEventListener('DOMContentLoaded', embed) : embed();
})();
