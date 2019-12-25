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
      @luggage = Luggage.new(luggage_params)
      @luggage.save ? flash_msg(:success, "托运【#{@luggage.no}】更新成功") : flash_msg(:error, @luggage.errors.messages)
      redirect_to_back 
    end

    def edit
    end

    def update
      @luggage.assign_attributes(luggage_params)
      @luggage.save ? flash_msg(:success, "托运【#{@luggage.no}】更新成功") : flash_msg(:error, @luggage.errors.messages)
      redirect_to_back
    end

    private
    def luggage_params
      params.require(:luggage).permit(:user_name,:card_type, :card_no, :total_charge, :remark,:store_at, :mobile, :store_at, :no)
    end

  end
end