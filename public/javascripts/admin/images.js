var assetBrowser = {
  init: function() {
    $$('a.image_asset').each(function (s) {
      Event.observe(s, 'click', function () {
        assetBrowser.submit(this);
        return false;
      });
    })
  },

  submit: function(link) {
    var win = tinyMCEPopup.getWindowArg("window");

    win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = link.href;

    if (win.ImageDialog.getImageData) win.ImageDialog.getImageData();
    // if (win.ImageDialog.showPreviewImage) win.ImageDialog.showPreviewImage(URL);

    tinyMCEPopup.close();
  }
};

tinyMCEPopup.onInit.add(assetBrowser.init, assetBrowser);