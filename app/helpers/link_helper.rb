module LinkHelper

  def link_to_blank(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second || {}
      link_to_blank(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2] || {}

      # override
      html_options.reverse_merge! target: '_blank'

      link_to(name, options, html_options)
    end
  end

  def link_to_void(*args, &block)
    link_to(*args.insert((block_given? ? 0 : 1), "javascript:void(0)"), &block)
  end

  def link_to_dialog(*args, &block)
    if block_given?
      options = args[0] || {}
      html_options = args[1] || {}
      html_options.deep_merge! onclick: "layer_page('', '#{options}')"
      link_to_void(html_options, &block)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2] || {}
      html_options.deep_merge! onclick: "layer_page('#{name}', '#{options}')"
      link_to_void(name, html_options)
    end
  end

  #配置URL的icon、class，样式通用
  def link_to_icon(*args)
    icons = {
      show: {icon: "&#xe6a4;", class: "layui-btn layui-btn-lg layui-btn-normal"},
      new: {icon: "&#xe6b9;", class: "layui-btn layui-btn-lg"},
      edit: {icon: "&#xe69e;", class: "layui-btn layui-btn-lg"},
      destroy: {icon: "&#xe640;", class: "layui-btn layui-btn-danger layui-btn-lg"},
      pay: {icon: "&#xe702;", class: "layui-btn layui-btn-danger layui-btn-lg" }
    }
    icons.default = {show: {icon: "&#xe6a4;", class: "layui-btn layui-btn-normal layui-btn-lg"}}

    #参数解析
    name = args[0]
    url = args[1]
    html_options = args[2] || {}


    #url的固定配置信息
    aname = Rails.application.routes.recognize_path(url, method: html_options[:method])[:action] #action的名字
    icon = icons[aname.to_sym]
    icon_name = icon[:icon]
    class_name = icon[:class]
    html_options.deep_merge! class: class_name
    url = url.include?("?") ? "#{url}&back=#{request.fullpath}" : "#{url}?&back=#{request.fullpath}"

    icon_block = lambda { ||  
      "<i class='iconfont'>#{icon_name}</i>#{name}".html_safe
    }

    link_to(url, html_options, &icon_block)
  end

end