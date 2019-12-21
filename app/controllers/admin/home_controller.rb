module Admin
  class HomeController < ApplicationController

    # 为每个controller自动加载@object
    before_action :load_resource

    layout "admin"

    private
    def load_resource
      class_name = controller_name.singularize.classify
      return unless class_exists?(class_name)
      scope = class_name.constantize
      if ['new', 'create'].include?(params[:action].to_s)
        resource = scope.new
      elsif params[:id]
        resource = scope.find(params[:id])
      else
        resource = nil
      end
      instance_variable_set("@#{controller_name.singularize}", resource)
    end

    def class_exists?(class_name)
      klass = Module.const_get(class_name)
      return klass.is_a?(Class)
    rescue NameError
      return false
    end

  end
end