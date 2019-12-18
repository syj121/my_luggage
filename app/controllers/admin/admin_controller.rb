module Admin
  class AdminController < ApplicationController

    def index
      render layout: "admin_out"
    end

  end
end