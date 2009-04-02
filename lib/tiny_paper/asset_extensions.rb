module TinyPaper
  module AssetExtensions
    def self.included(base)
      base.class_eval do
        named_scope :by_title, lambda{ |search_term| {:conditions => ["LOWER(title) LIKE ?", "%#{search_term.to_s.downcase}%"]}}
        def self.assets_paginate(params)
          options = {
            :page => params[:page],
            :per_page => 25,
            :conditions => nil
          }
          
          if ['title', 'asset_content_type'].include?(params[:sort_by]) && %w(asc desc).include?(params[:sort_order])
            options[:order] = "#{params[:sort_by]} #{params[:sort_order]}"
          end          
          
          if !params[:images].blank?
            options[:per_page] = (params[:view] == "thumbnails") ? 15 : 25
            options[:conditions] = ["asset_content_type IN (?)", Admin::TinyPaperController::WebImageTypes]
          end
          
          self.by_title(params[:title]).paginate(options)
        end
      end
    end
  end  
end