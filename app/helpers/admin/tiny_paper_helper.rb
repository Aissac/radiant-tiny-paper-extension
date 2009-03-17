module Admin::TinyPaperHelper
  SORT_CYCLE = {'asc' => 'desc', 'desc' => 'none', 'none' => 'asc'}
  
  def sortable_column_head(label, attribute)
    current_order = (currently_sorting_by?(attribute) && %w(none asc desc).include?(list_params[:sort_order])) ? list_params[:sort_order] : 'none'
    dom_class = currently_sorting_by?(attribute) ? "sort_#{current_order}" : nil
    
    link_to(label,
      params.merge(list_params).merge(:sort_by => attribute, :sort_order => SORT_CYCLE[current_order], :reset => 1),
      :class => dom_class)
  end
  
  def reset_filters_tag
    link_to("", {:reset => 1}, :id => 'reset', :style => 'display:none')
  end
  
  def link_to_size(k,v)
    v.blank? ? link_to_image(k).to_s + (v.to_s) : link_to_image(k).to_s + ', ' + (v.to_s)
  end
  
  def link_to_image(k)
    link_to k, {:size => k}, :class => dom_class(k)
  end
  
  def dom_class(k)
    list_params[:size] == k.to_s ? "filtered" : nil
  end
  
  def show_flash_message
    [:notice, :error, :success].map do |f|
      content_tag :div, flash[f], :class => "flash #{f}" if flash[f]
    end
  end

  def page_list(page)
    "<li><a href=#{page.url}>#{page.title}</a></li>" + 
    page.children.collect do |child| 
      unless child.virtual? || !child.published?
        "<li class='no_bullet'><ul> #{page_list(child)} </ul></li>"
      end
    end.join
  end
  
  protected
  
  def currently_sorting_by?(attribute)
    list_params[:sort_by] == attribute.to_s
  end
end