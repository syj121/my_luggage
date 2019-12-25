class Luggage < ApplicationRecord

  has_many :items, class_name: "LuggageItem", counter_cache: :items_count

  default_value_for :items_count, 1
  default_value_for :card_type, 1

  #证件类型
  CARD_TYPE = {1 => "身份证", 2 => "驾驶证", 3 => "护照", 4 => "港澳通行证", 5 => "台胞证"}
  #结账状态
  PAY_STATUS = {1 => "未结账", 2 => "已结账"}
  #状态
  WORKFLOW_STATUS = {stash: "新增", paid: "结账", printed: "已打印"}


  include Workflow
  workflow do
    state :stash do 
      event :pay, transitions_to: :piad
    end
    state :paid do 
      event :print, transitions_to: :printed
    end
    state :printed
  end

  def generate_no(gstore_at=false)
    self.store_at = Time.now.to_s if gstore_at
    self.no = "#{Date.current.to_s(:number)}#{(Luggage.last.try(:id).to_i+1).to_s.rjust(4,"0")}"
  end


end
