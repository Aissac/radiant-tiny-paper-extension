/* I don't even know where this code comes from. It looks like a
   simple TinyMCE plugin written for replacing some HTML tags with
   placeholder images. The original version was modified and copied in
   the first tinymce_filter extension for Radiant (hosted on Google
   Code). I updated it to the latest TinyMCE API and fixed some stuff.
   Daniele Gozzi

   Original copyright notice follows.
*/
/**** 
 * I'm not even gonna copyright this, that's just silly.
 * Feel free to improve on this code and re-upload it.
 * Tijmen Schep, Holland, 9-10-2005
 ****/

(function() {
  tinymce.create('tinymce.plugins.CodeProtectPlugin', {
    init: function(ed, url) {
        ed.onGetContent.add(function(ed,o) {
          var regex = new RegExp('<hr rel="([^"]*)?" class="mceItemRadiantCode" title="(.*?)" />', 'g');
          var m = o.content.match(regex);
          if (!(m == null)) {
          for (i=0; i<m.length; i++) {
            var match = unescape(m[i].replace(regex, '$1'));
            o.content = o.content.replace(m[i], match);
          }
        }
      });
      ed.onBeforeSetContent.add(function(ed, o) {
        /* Regexp taken from Phil Haack blog. Thanks Phil! */
        var m = o.content.match(/<\/?r:\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/g);
        var content = o.content;
        if (!(m == null)) {
          for (i=0; i < m.length; i++) {
            var title = m[i].replace(/"/g, "'");
            var match = escape(m[i]);
            var regex = new RegExp('(' + m[i] + ')', 'i');
            content = content.replace(regex, '<hr rel="' + match + '" class="mceItemRadiantCode" title="' + title + '" />');
          }
        }
        o.content = content;
      });
    }
  });

  // Register plugin
  tinymce.PluginManager.add('codeprotect', tinymce.plugins.CodeProtectPlugin);
})();
