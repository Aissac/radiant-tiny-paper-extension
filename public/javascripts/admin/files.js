var assetBrowser = {
  init: function() {
    $$('#tp_assets a').each(function (s) {
      Event.observe(s, 'click', function () {
        assetBrowser.submit(this);
        return false;
      });
    });
  },
  
  submit: function(href) {
    var win = tinyMCEPopup.getWindowArg("window");
    
    win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = href;
    
    tinyMCEPopup.close();
  }
};

document.observe("dom:loaded", function() { 
  tinyMCEPopup.onInit.add(assetBrowser.init, assetBrowser);
  if ($("title").value != null && $("title").value.length != 0) {
    $("reset").show();
  }
});