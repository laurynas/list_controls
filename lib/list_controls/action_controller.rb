require 'ostruct'

module ListControls
  module ActionController
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def enable_list_controls(options = {})
        include ::ListControls::ActionController::InstanceMethods
        
        attr_reader :filters
        
        before_filter :assign_filters
      end
    end
  
    module InstanceMethods
      
      protected
      
      def default_filters
        {}
      end
      
      def assign_filters
        session[:list_controls]||= {}
        
        session_store = session[:list_controls][self.class.to_s]||= {}
        session_store[:filters] ||= default_filters
        session_store[:filters].merge!(params[:filters] || {})
        
        tmp_filters  = session_store[:filters]
        
        @filters = OpenStruct.new(tmp_filters)
        
        session[:list_controls][self.class.to_s] = session_store
      end
    end
  
  end
end

::ActionController::Base.send(:include, ::ListControls::ActionController)
