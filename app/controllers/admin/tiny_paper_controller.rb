class Admin::TinyPaperController < ApplicationController
  layout "picker"
  
  WebImageTypes = %w( image/jpg image/jpeg image/gif image/png image/x-png )  
  
  def images
    include_javascript "tiny_mce/tiny_mce_popup"    
    include_javascript "admin/images"
    
    conditions = ["asset_content_type IN (?)", WebImageTypes]
    
    @assets = Asset.paginate(
      :page       => params[:page] || 1,
      :per_page   => 12,
      :conditions => conditions,
      :order      => "title ASC"
    )
  end
  
  # def files
  #   
  #   @assets = Asset.paginate(
  #     :page       => params[:page] || 1,
  #     :per_page   => 6,
  #     :order      => "title ASC"
  #   )
  # end
end