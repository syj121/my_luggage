class Luggage < ApplicationRecord

  has_many :items, class_name: "LuggageItem", counter_cache: :items_count

  #证件类型
  CARD_TYPE = {1 => "身份证", 2 => "驾驶证", 3 => "护照", 4 => "港澳通行证", 5 => "台胞证"}
  #结账状态
  PAY_STATUS = {1 => "未结账", 2 => "已结账"}

  before_save do 
    self.generate_no
  end

  def generate_no(gstore_at=false)
    self.store_at = Time.now.to_s if gstore_at
    self.no = "#{Date.current.to_s(:number)}#{(Luggage.last.try(:id).to_i+1).to_s.rjust(4,"0")}"
  end

end
