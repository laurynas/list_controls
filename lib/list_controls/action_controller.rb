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
        
        before_filter :list_controls_assign_filters
        
        @list_controls_default_filters = options[:default_filters] || {}
      end

      def list_controls_default_filters
        @list_controls_default_filters
      end
    end
  
    module InstanceMethods
      
      protected
      
      def list_controls_default_filters
        f = self.class.list_controls_default_filters
        f.is_a?(Proc) ? f.call(self) : f
      end
      
      def list_controls_assign_filters
        session[:list_controls]||= {}
        
        session_store = session[:list_controls][self.class.to_s]||= {}
        session_store[:filters] ||= list_controls_default_filters
        session_store[:filters].merge!(params[:filters] || {})
        
        tmp_filters  = session_store[:filters]
        
        @filters = OpenStruct.new(tmp_filters)
        
        session[:list_controls][self.class.to_s] = session_store
      end
    end
  
  end
end

::ActionController::Base.send(:include, ::ListControls::ActionController)
