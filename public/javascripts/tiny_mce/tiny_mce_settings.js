tinyMCE.init({   
  editor_selector : "mceEditor",
  editor_deselector : "noMceEditor",
	mode : "textareas",
	theme : "advanced",
  extended_valid_elements: "r:*",
  plugins: "codeprotect,inlinepopups",
  content_css: "/stylesheets/extensions/tiny_mce/application.css",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
	apply_source_formatting : true,
	relative_urls : false,
	file_browser_callback : "assetMethods.browserHook",
	height : "400px"
});