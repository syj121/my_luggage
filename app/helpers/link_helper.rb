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

  def link_to_icon(*args)
    icons = {"新增": "&#xe6b9;", "修改": "&#xe69e;", "删除": "&#xe640;", "查看": "&#xe6a4;", "结账": "&#xe702;"}

    name = args[0]
    options = args[1]
    html_options = args[2]

    icon_block = lambda { ||  
      "<i class='iconfont'>#{icons[name.to_sym]}</i>#{name}".html_safe
    }

    link_to(options, html_options, &icon_block)
  end

end