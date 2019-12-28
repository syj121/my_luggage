module Admin
  class LuggagesController < Admin::HomeController

    before_action :check_auth

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

    def pay
      return redirect_to_back unless @luggage.can_pay?
      @luggage.pay_charge
    end

    def save_charge
      @luggage.update(pay_status: 2)
      flash_msg(:success, "已收费")
      redirect_to_back
    end

    def print
      render layout: "admin_print"
    end

    private
    def luggage_params
      params.require(:luggage).permit(:user_name,:card_type, :card_no, :remark,:store_at, :mobile, :store_at, :no, :items_count)
    end

    def luggage_charge_params
      params.require(:luggage).permit(:pick_at, :total_charge)
    end

    #检查变更权限
    def check_auth
      return true if @luggage.blank?
      c = case action_name
      when "edit","update"
        @luggage.can_edit?
      when "pay","save_charge"
        @luggage.can_pay?
      else
        true
      end
      return redirect_to_back unless c
    end

  end
end