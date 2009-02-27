var assetBrowser = {
  init: function() {
    $$('#tp_asset_images a').each(function (s) {
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
    if (win.ImageDialog.showPreviewImage) win.ImageDialog.showPreviewImage(link.href);

    tinyMCEPopup.close();
  }
};

tinyMCEPopup.onInit.add(assetBrowser.init, assetBrowser);