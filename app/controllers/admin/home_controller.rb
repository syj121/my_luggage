module Admin
  class HomeController < ApplicationController

    def index  
      render layout: "admin"
    end

  end
end