# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TinyPaperExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/tiny_paper"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :tiny_paper
  #   end
  # end
  
  def activate
    TinyMceFilter
    Admin::PagesController.class_eval { include TinyMce::AddJavascriptsAndStyles }
  	admin.page.edit.add :part_controls, "admin/page/tiny_mce_control"
  end
  
  def deactivate
    # admin.tabs.remove "Tiny Paper"
  end
  
end
