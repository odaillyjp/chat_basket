module ApplicationHelper
  def class_name_with_modifier(original_name, modifier, condition)
    return original_name unless condition

    class_name = [original_name, modifier].join('--')
    [original_name, class_name].join(' ')
  end
end
