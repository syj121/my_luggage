# -*- encoding : utf-8 -*-

#设置全局可用变量
$settings = {site_name: "货物托管", company_name: "公交信禾长云股份公司（拱北通道汽车站）"}

#如果不设置默认值，页面展示，将展示时区，时间插件或将“输入”无效
Date::DATE_FORMATS[:default] = "%Y-%m-%d"
Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M:%S"

class Time

  def index_day
    self.strftime('%Y%m%d').to_i
  end

  def index_month
    self.strftime('%Y%m').to_i
  end

end