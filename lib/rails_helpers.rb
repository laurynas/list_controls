module ListControls
  module RailsHelpers
    def sort(filters, options = {}, html_options = {})
      options[:params_scope] ||= :filters
      options[:ascend_scope] ||= "ascend_by_#{options[:by]}"
      options[:descend_scope] ||= "descend_by_#{options[:by]}"
      options[:sort_class] ||= 'sort'
      
      current_order = filters['order']
      
      ascending = current_order == options[:ascend_scope]
      new_scope = ascending ? options[:descend_scope] : options[:ascend_scope]
      selected = [options[:ascend_scope], options[:descend_scope]].include?(current_order)
      
      css_classes = html_options[:class] ? html_options[:class].split(" ") : []

      if selected
        if ascending
          css_classes << options[:sort_class] + "-up"
        else
          css_classes << options[:sort_class] + "-down"
        end
      else
        css_classes << options[:sort_class]
      end
      
      html_options[:class] = css_classes.join(" ")

      url_options = {
        options[:params_scope] => { :order => new_scope }
      }.deep_merge(options[:params] || {})
      
      link_to options[:as], url_for(url_options), html_options
    end
  end
end

::ActionController::Base.helper(ListControls::RailsHelpers)

