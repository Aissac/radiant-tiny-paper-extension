var assetBrowser = {  
  init: function() {
    $$('#tp_assets a').each(function (s) {
      Event.observe(s, 'click', function () {
        assetBrowser.submit(this);
        return false;
      });
    });
  },

  submit: function(link) {
    var win = tinyMCEPopup.getWindowArg("window");

    win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = link.href;

    if (win.ImageDialog.getImageData) win.ImageDialog.getImageData();
    if (win.ImageDialog.showPreviewImage) win.ImageDialog.showPreviewImage(link.href);

    tinyMCEPopup.close();
  }
};

document.observe("dom:loaded", function() { 
  tinyMCEPopup.onInit.add(assetBrowser.init, assetBrowser);
  if ($("title").value != null && $("title").value.length != 0) {
    $("reset").show();
  }
  Event.observe('sort_order', 'change', function () {
    $("tp_filter").submit();
  })
});

function when_starting () {
  $("spinner").show();
  $("reset").show();
}

function when_completing () {
  $("spinner").hide();
  $$('#tp_assets a').each(function (s) {
    s.stopObserving('click');
  });
  $$('#tp_assets a').each(function (s) {
    Event.observe(s, 'click', function () {
      assetBrowser.submit(this);
      return false;
    });
  });
}