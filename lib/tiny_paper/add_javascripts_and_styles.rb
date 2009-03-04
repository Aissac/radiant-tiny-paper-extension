module TinyPaper
  module AddJavascriptsAndStyles
    def self.included(base)
      base.class_eval do
        before_filter :add_tinymce_assets
        
        private        
          def add_tinymce_assets
            include_javascript "tiny_mce/tiny_mce"
            include_javascript "tiny_mce/tiny_mce_settings"
            include_javascript "tiny_mce/tiny_mce_toggle"
            include_javascript "tiny_mce/application"
          end
      end
    end
  end
end