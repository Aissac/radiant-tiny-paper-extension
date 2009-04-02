class Admin::TinyPaperController < ApplicationController
  layout "picker"
  WebImageTypes = %w( image/jpg image/jpeg image/gif image/png image/x-png )
  DefaultParams = [:title, :page, :sort_by, :sort_order]
  
  def images
    attach_js_css
    filter_by_params([:view, :size])
    list_params[:images] = 'images'
    @assets = Asset.assets_paginate(list_params)
    @thumbnails = Asset.attachment_definitions[:asset][:styles]

    respond_to do |f|
      f.html { render }
      f.js { 
        if list_params[:view] == "thumbnails"
          render :partial => 'images_images.html.haml', :layout => false
        else
          render :partial => 'images_titles.html.haml', :layout => false
        end
      }
    end
  end
  
  def files
    attach_js_css
    filter_by_params
    @assets = Asset.assets_paginate(list_params)
    
    respond_to do |f|
      f.html { render }
      f.js { render :partial => 'files_titles.html.haml', :layout => false }
    end
  end
  
  def pages
    attach_js_css
    @homepage = Page.find(:first, :conditions => {:parent_id => nil}, :include => :children)
  end
  
  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:success] = "Asset successfully uploaded."
      redirect_to :"#{params[:type]}"
    else
      flash[:error] = @asset.errors.full_messages.join(" ")
      redirect_to :"#{params[:type]}"
    end
  end
  
  def list_params
    @list_params ||= {}
  end
  helper_method :list_params
  
  protected
    def filter_by_params(args=[])
      args = args + DefaultParams
      args.each do |arg|
        list_params[arg] = params[:reset] ? params[arg] : params[arg] || cookies[arg]
      end
      list_params[:page] ||= "1"
      list_params[:size] ||= "original"
      list_params[:view] ||= "thumbnails"
      
      update_list_params_cookies(args)
      
      # for will_paginate
      params[:page] = list_params[:page]
    end
  
    def update_list_params_cookies(args)
      args.each do |key|
        cookies[key] = { :value => list_params[key], :path => "/#{controller_path}" }
      end
    end
    
    def attach_js_css
      include_stylesheet "admin/tiny_paper"
      include_javascript "tiny_mce/tiny_mce_popup"
      include_javascript "admin/tiny_paper"
      include_javascript "controls"
    end 
end