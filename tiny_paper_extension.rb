# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TinyPaperExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/tiny_paper"

  define_routes do |map|
    map.resources(:tiny_paper,
      :controller   => 'admin/tiny_paper',
      :path_prefix  => 'admin',
      :collection   => {
        :images => :get,
        :files  => :get
      }
    )
  end
  
  def activate
    TinyMceFilter
    Admin::PagesController.class_eval { include TinyMce::AddJavascriptsAndStyles }
  	admin.page.edit.add :part_controls, "admin/page/tiny_mce_control"
  end
  
  def deactivate
    # admin.tabs.remove "Tiny Paper"
  end
  
end
