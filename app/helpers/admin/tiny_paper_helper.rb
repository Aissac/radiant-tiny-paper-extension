module Admin::TinyPaperHelper
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
end