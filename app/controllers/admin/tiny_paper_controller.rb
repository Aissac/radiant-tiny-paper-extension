class Admin::TinyPaperController < ApplicationController
  layout "picker"
  WebImageTypes = %w( image/jpg image/jpeg image/gif image/png image/x-png )  
  
  def images
    include_stylesheet "admin/tiny_paper"
    include_javascript "tiny_mce/tiny_mce_popup"    
    include_javascript "admin/images"
    
    conditions = ["asset_content_type IN (?)", WebImageTypes]

    unless params[:title].blank?
      conditions.first << " AND title LIKE ?"
      conditions << "%#{params[:title]}%"
    end
    
    filter_by_params([:title, :page, :view, :size])
    @assets = Asset.paginate(
      :page       => params[:page] || 1,
      :per_page   => 12,
      :conditions => conditions,
      :order      => "title ASC"
    )
    
    @thumbnails = Asset.attachment_definitions[:asset][:styles]
  end
  
  # def files
  #   
  #   @assets = Asset.paginate(
  #     :page       => params[:page] || 1,
  #     :per_page   => 6,
  #     :order      => "title ASC"
  #   )
  # end
  
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
      
      # pentru will_paginate
      params[:page] = list_params[:page]
    end
  
    def update_list_params_cookies(args)
      args.each do |key|
        cookies[key] = { :value => list_params[key], :path => "/#{controller_path}" }
      end
    end
    
end