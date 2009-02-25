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
    # admin.tabs.add "Tiny Paper", "/admin/tiny_paper", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Tiny Paper"
  end
  
end
