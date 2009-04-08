require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::TinyPaperController do

  dataset :users
  
  before do
    login_as :developer
  end
  
  describe "handling GET images" do
    
    before do
      @assets = (1..10).map { |i| mock_model(Asset)}
      @thumbnails =  {:asset => {:styles => {:thumbnail=>["100x100>", :png], :icon=>["42x42#", :png], :normal=>"640x640>"}}}
      
      Asset.stub!(:assets_paginate).and_return(@assets)
      Asset.stub!(:attachment_definitions).and_return(@thumbnails)
      
      @list_params = {:view => "thumbnails"}
      controller.stub!(:list_params).and_return(@list_params)
    end
    
    def do_http_get
      get :images
    end
    
    def do_xhr_get(options={})
      xhr :get, 'images', options
    end
    
    it "is successful" do
      do_http_get
      response.should be_success
    end
    
    it "renders the images template" do
      do_http_get
      response.should render_template(:images)
    end
    
    it "parses list_params" do
      controller.should_receive(:filter_by_params).with([:view, :size])
      do_http_get
    end
    
    it "finds all assets with list params" do
      Asset.should_receive(:assets_paginate).with(@list_params).and_return(@assets)
      do_http_get
    end
    
    it "assigns the found assets to the view" do
      do_http_get
      assigns[:assets].should == @assets
    end
    # xhr request below
    it "renders the images partial when view is set to thumbnails" do
      controller.should_receive(:render).with(:partial => 'images_images.html.haml', :layout => false).and_return(true)
      do_xhr_get
    end
    
    it "renders the titles list partial when view is set to text list" do
      controller.should_receive(:render).with(:partial => 'images_titles.html.haml', :layout => false).and_return(true)
      do_xhr_get(:view => 'text_list')
    end
  end
  
  describe "handling GET files" do
    before do
      @assets = (1..10).map { |i| mock_model(Asset)}
      
      Asset.stub!(:assets_paginate).and_return(@assets)
      
      @list_params = {:view => "thumbnails"}
      controller.stub!(:list_params).and_return(@list_params)
    end
    
    def do_http_get
      get :files
    end
    
    def do_xhr_get(options={})
      xhr :get, 'files', options
    end
    
    it "is succesful" do
      do_http_get
      response.should be_success
    end
    
    it "renders the files template" do
      do_http_get
      response.should render_template(:files)
    end
    
    it "parses list_params" do
      controller.should_receive(:filter_by_params).with()
      do_http_get
    end
    
    it "finds all assets with list params" do
      Asset.should_receive(:assets_paginate).with(@list_params).and_return(@assets)
      do_http_get
    end
    
    it "assigns the found assets to the view" do
      do_http_get
      assigns[:assets].should == @assets
    end
    # xhr request below
    it "renders the files titles partial when view is set to thumbnails" do
      controller.should_receive(:render).with(:partial => 'files_titles.html.haml', :layout => false).and_return(true)
      do_xhr_get
    end
  end
  
  describe "handling GET pages" do
    
    before do
      @homepage = mock_model(Page, :parent_id => nil)
      Page.stub!(:find).and_return(:@homepage)
    end
    
    def do_get
      get :pages
    end
    
    it "is succesful" do
      do_get
      response.should be_success
    end
    
    it "renders the pages template" do
      do_get
      response.should render_template(:pages)
    end
    
    it "finds the homepage" do
      Page.should_receive(:find).with(:first, :conditions => {:parent_id => nil}, :include    => :children)
      do_get
    end
  end
  
  describe "handling POST create" do
    
    before do
      @asset = mock_model(Asset, :save => true)
      Asset.stub!(:new).and_return(@asset)
    end
    
    def do_post(options={})
      post :create, :type => 'images', :asset => options
    end
    
    it "creates a new asset" do
      Asset.should_receive(:new).with("title" => "test_title")
      do_post(:title => "test_title")
    end
    
    it "redirects on success" do
      do_post
      response.should redirect_to('admin/tiny_paper/images')
    end

    it "redirect to the images/files template on failure" do
      @errors = mock("error", :full_messages => mock("full_messages", :join => true))
      @asset.stub!(:errors).and_return(@errors)
      @asset.should_receive(:save).and_return(false)
      do_post
      response.should redirect_to('admin/tiny_paper/images')
    end 
  end
  
  describe "including member assets" do

    [:images, :files, :pages].each do |action|
      it "#{action} includes javascripts" do
        ['tiny_mce/tiny_mce_popup','admin/tiny_paper','controls'].each do |js|
          controller.should_receive(:include_javascript).with(js)
        end
          get action
      end
      
      it "#{action} includes stylesheets" do
        controller.should_receive(:include_stylesheet).with("admin/tiny_paper")
        get action
      end
    end

  end
  
  describe "parsing list_params" do
    def do_get(options={})
      get :images, options
    end
  
    def filter_by_params(args=[])
      @controller.send(:filter_by_params, args)
    end
    
    def list_params
      @controller.send(:list_params)
    end
    
    def set_cookie(key, value)
      request.cookies[key] = CGI::Cookie.new('name' => key, 'value' => value)
    end
    
    it "should take arbitrary params" do
      do_get(:name => 'Blah', :test => 10)
      filter_by_params([:name, :test])
      [:name, :test].each {|p| response.cookies.keys.should include(p.to_s)}
    end
        
    it "should load list_params from cookies by default" do
      set_cookie('page', '98')
      do_get
      filter_by_params
      list_params[:page].should == '98'
    end
    
    it "should prefer request params over cookies" do
      set_cookie('page', '98')
      do_get(:page => '99')
      filter_by_params
      list_params[:page].should == '99'
    end
    
    it "should update cookies with new values" do
      set_cookie('page', '98')
      do_get(:page => '99')
      filter_by_params
      response.cookies['page'].should == ['99']
    end
    
    it "should reset list_params when params[:reset] == 1" do
      set_cookie('page', '98')
      do_get(:reset => 1)
      filter_by_params
      response.cookies['page'].should == ["1"]
    end
    it "should set params[:page] if loading from cookies (required for will_paginate to work)" do
      set_cookie('page', '98')
      do_get
      filter_by_params
      params[:page].should == '98'
    end
  end
  
end