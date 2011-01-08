module ActionController
  module ListControls
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def can_filter_and_sort(options = {})
        include ActionController::FilterAndSort::InstanceMethods
        
        before_filter :set_filters
      end
    end
  
    module InstanceMethods
      
      protected
      
      def default_filters
        {}
      end
      
      def get_filters
        @filters
      end
      
      def set_filters
        session[:filter_and_sort]||= {}
        
        session_store           = session[:filter_and_sort][self.class.to_s]||= {}
        session_store[:filters] ||= default_filters
        session_store[:filters].merge!(params[:filters] || {})
        
        @filters  = session_store[:filters]
        
        session[:filter_and_sort][self.class.to_s] = session_store
      end
    end
  
  end
end

::ActionController::Base.send(:include, ActionController::ListControls)
