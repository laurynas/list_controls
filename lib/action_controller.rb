module ActionController
  module ListControls
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def can_filter_and_sort(options = {})
        include ActionController::ListControls::InstanceMethods
        
        attr_reader :filters
        
        before_filter :set_filters
      end
    end
  
    module InstanceMethods
      
      protected
      
      def default_filters
        {}
      end
      
      def set_filters
        session[:list_controls]||= {}
        
        session_store = session[:list_controls][self.class.to_s]||= {}
        session_store[:filters] ||= default_filters
        session_store[:filters].merge!(params[:filters] || {})
        
        @filters  = session_store[:filters]
        
        session[:list_controls][self.class.to_s] = session_store
      end
    end
  
  end
end

::ActionController::Base.send(:include, ActionController::ListControls)
