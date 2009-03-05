class Admin::TinyPaperController < ApplicationController
  layout "picker"
  WebImageTypes = %w( image/jpg image/jpeg image/gif image/png image/x-png )
  
  def images
    attach_js_css
    include_javascript "admin/images"
    filter_by_params([:title, :page, :view, :size, :sort_order])
    @assets = Asset.assets_paginate(list_params)
    @thumbnails = Asset.attachment_definitions[:asset][:styles]

    respond_to do |f|
      f.html { render }
      f.js { 
        if list_params[:view] == "thumbnails"
          render :partial => 'images_images.html.erb', :layout => false
        else
          render :partial => 'images_titles.html.erb', :layout => false
        end
      }
    end
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:success] = "Asset successfully uploaded."
      redirect_to :"#{params[:current_page]}_tiny_paper"
    else
      flash[:error] = "There was a problem!"
      render :action => params[:current_page].to_sym
    end
  end
  
  def files
    attach_js_css
    include_javascript "admin/files"
    filter_by_params([:title, :page, :sort_order])
    @assets = Asset.assets_paginate(list_params)
    
    respond_to do |f|
      f.html { render }
      f.js { 
        render :partial => 'files_titles.html.erb', :layout => false
      }
    end
  end
  
  def list_params
    @list_params ||= {}
  end
  helper_method :list_params
  
  protected
    def filter_by_params(args)
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
      include_javascript "controls"
    end 
end