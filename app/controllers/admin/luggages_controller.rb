module Admin
  class LuggagesController < Admin::HomeController

    def index
      @q = Luggage.ransack(params[:q])
      @luggages = @q.result.page(params[:page])
    end

    def new
      @luggage.generate_no(true)
    end

    def create
      #@luggage = Luggage.create(luggage_params)
      #render json: {success: false, msg: "操作失败"}
      respond_to do |format| 
        @back_json = {"success" => false, "msg" => "操作失败"}
        format.js 
      end
    end

    def edit
    end

    def update
      @luggage.assign_attributes(luggage_params)
      @luggage.save
    end

    private
    def luggage_params
      params.require(:luggage).permit(:user_name,:card_type, :card_no, :total_charge, :remark,:store_at, :mobile)
    end

  end
end