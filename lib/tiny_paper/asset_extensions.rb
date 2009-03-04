module TinyPaper
  module AssetExtensions
    def self.included(base)
      base.class_eval do
        named_scope :by_title, lambda{ |search_term| {:conditions => ["LOWER(title) LIKE ?", "%#{search_term.to_s.downcase}%"]}}

        def self.assets_paginate(params)
          options = {
            :page => params[:page],
            :per_page => params[:view] == "thumbnails" ? 12 : 24
          }
          options[:order] = params[:sort_order].blank? ? "title ASC" : "title " + params[:sort_order]
          self.by_title(params[:title]).paginate(options)
        end
        
      end
    end
  end  
end