# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TinyPaperExtension < Radiant::Extension
  version "0.9"
  description "Radiand CMS Tiny MCE support using Paperclipped assets"
  url "http://blog.aissac.ro/radiant/tiny-paper-extension/"

  define_routes do |map|
    map.with_options(:controller => 'admin/tiny_paper') do |asset|
      asset.images            "/admin/tiny_paper/images",                 :action => 'images'
      asset.images_sizes      "/admin/tiny_paper/:id/images_sizes",       :action => 'images_sizes'
      asset.files             "/admin/tiny_paper/files",                  :action => 'files'
      asset.pages             "/admin/tiny_paper/pages",                  :action => 'pages'
      asset.create            "/admin/tiny_paper/create",                 :action => 'create'
    end
  end
  
  def activate
    TinyMceFilter
    Asset.class_eval { include TinyPaper::AssetExtensions }
    Admin::PagesController.class_eval { include TinyPaper::AddJavascriptsAndStyles }
        
  	admin.page.edit.add :part_controls, "admin/page/tiny_mce_control"
  end
  
  def deactivate
    # admin.tabs.remove "Tiny Paper"
  end
  
end
