class Luggage < ApplicationRecord

  #has_many :items, class_name: "LuggageItem", counter_cache: :items_count

  default_value_for :items_count, 1
  default_value_for :card_type, 1

  default_scope -> {order(id: :desc)}

  #证件类型
  CARD_TYPE = {1 => "身份证", 2 => "驾驶证", 3 => "护照", 4 => "港澳通行证", 5 => "台胞证"}
  #结账状态
  PAY_STATUS = {1 => "未结账", 2 => "已结账"}
  #所有状态
  PAY_STATUS_ALL = PAY_STATUS.merge({3 => "未打印"})
  #状态
  #WORKFLOW_STATUS = {stash: "新增", paid: "已结账", printed: "已打印"}

  before_create do 
    self.index_day = self.store_at.index_day
  end

  def generate_no(gstore_at=false)
    self.store_at = Time.now.to_s if gstore_at
    self.no = "#{Date.current.to_s(:number)}#{(Luggage.last.try(:id).to_i+1).to_s.rjust(4,"0")}"
  end

  #计算收费
  def pay_charge
    current_time = Time.now
    t = current_time - self.store_at
    tm = t/60.0  #分钟
    th = t/3600.0 #小时
    total = case 
    when tm < 135
      pay_charge_1(t)
    when th < 24
      pay_charge_2(tm)
    else
      pay_charge_3(th)
    end
    self.total_charge = total
    self.pick_at = current_time
    self.save
  end

  #第一阶段收费
  def pay_charge_1(t)
    8
  end

  #第二阶段收费：分钟
  def pay_charge_2(tm)
    h = tm.floor  #取整
    s = tm.ceil   #取余
    h += 1 if s > 15
    return [(h-2)*4+8, 25].min
  end

  #第三阶段收费：小时
  def pay_charge_3(th)
    day = t/24   #天数
    tm = (t - 24*day)*60  #剩余分钟
    pay_charge_2(tm) + 25 * day
  end

  #是否可以结账
  def can_pay?
    self.pay_status == 1
  end

  #是否可以编辑
  def can_edit?
    self.pay_status == 1
  end

  #是否可以展示
  def can_show?
    self.pay_status == 1
  end

  def can_show_charge?
    self.pay_status > 1
  end

  def can_print?
    self.pay_status >= 2
  end

end
