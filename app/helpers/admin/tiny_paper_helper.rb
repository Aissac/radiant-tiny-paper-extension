module Admin::TinyPaperHelper

  def filter_actions_tag
    submit_tag("Filter") + content_tag('span', ' | ' + reset_filters_tag)
  end

  def reset_filters_tag
    link_to("Reset", :reset => 1, :view => list_params[:view], :size => list_params[:size])
  end
  
  def link_to_size(k,v)
    link_to_image(k).to_s + ", " + (v.to_s)
  end
  
  def link_to_image(k)
    link_to k, list_params.merge(:size => k), :class => dom_class(k)
  end
  
  def dom_class(k)
    list_params[:size] == k.to_s ? "filtered" : nil
  end

end