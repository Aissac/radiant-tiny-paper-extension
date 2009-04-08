var assetBrowser = {  
  init: function() {
    $$('#tp_assets a').each(function (s) {
      Event.observe(s, 'click', function () {
        $$('span.tp_image_sizes').each(function (sp) {
          sp.hide();
        });
        if ($('type').value == 'images' ) {
          var span = this.down('span.tp_image_sizes');
          if (span) {
            span.show();
          }
          return false; 
        }
        if ($('type').value == 'files' || $('type').value == 'pages' ) {
          assetBrowser.submit_file(this.href);
          return false; 
        }
      });
    });
    $$("#tp_sizes a").each(function (s) {
      Event.observe(s, 'click', function () {
        assetBrowser.submit_image(this);
      })
    });
  },

  submit_image: function(link) {
    var win = tinyMCEPopup.getWindowArg("window");

    win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = link.href;

    if (win.ImageDialog.getImageData) win.ImageDialog.getImageData();
    if (win.ImageDialog.showPreviewImage) win.ImageDialog.showPreviewImage(link.href);

    tinyMCEPopup.close();
  },
  
  submit_file: function(href) {
    var win = tinyMCEPopup.getWindowArg("window");
    
    win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = href;

    tinyMCEPopup.close();
  }
};

document.observe("dom:loaded", function() { 
  tinyMCEPopup.onInit.add(assetBrowser.init, assetBrowser);
  if ( $('title') && ($("title").value != null && $("title").value.length != 0)) {
    $("reset").show();
  };
  if ($('sort_order')) {
    Event.observe('sort_order', 'change', function () {
      $("tp_sort").submit();
    }) 
  };
  if ($('view_mode')) {
    Event.observe('view_mode', 'change', function () {
      $("tp_view_mode").submit();
    }) 
  };
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
  $$('#tp_sizes a').each(function (s) {
    s.stopObserving('click');
  });
  $$('#tp_assets a').each(function (s) {
    Event.observe(s, 'click', function () {
      $$('span.tp_image_sizes').each(function (sp) {
        sp.hide();
      });
      if ($('type').value == 'images' ) {
        var span = this.down('span.tp_image_sizes');
        if (span) {
          span.show();
        }
        return false; 
      }
      if ($('type').value == 'files' || $('type').value == 'pages' ) {
        assetBrowser.submit_file(this.href);
        return false; 
      }
    });
  });
  $$("#tp_sizes a").each(function (s) {
    Event.observe(s, 'click', function () {
      assetBrowser.submit_image(this);
    })
  });
  if ($("sort_order")) {
    $("sort_order").stopObserving('change');
    Event.observe('sort_order', 'change', function () {
      $("tp_sort").submit();
    })
  }
  if ($("view_mode")) {
    $("view_mode").stopObserving('change');
    Event.observe('view_mode', 'change', function () {
      $("tp_view_mode").submit();
    })
  }
}