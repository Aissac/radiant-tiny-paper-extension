assetMethods = {
  browserHook: function(field_name, url, type, win) {
    tinyMCE.activeEditor.windowManager.open({
      file:           "/admin/tiny_paper/" + type + "s",
      title:          (type == "image" ? "Image" : "File") + " Browser",
      width:          800,
      height:         (type == "image" ? 580 : 580),
      resizable:      "yes",
      inline:         "yes",
      close_previous: "no"
    }, {
      window: win,
      input:  field_name
    });
    return false;
  }
}
