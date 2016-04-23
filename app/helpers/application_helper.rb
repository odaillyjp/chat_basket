module ApplicationHelper
  def add_modifier_class(original_name, modifier, condition)
    return original_name unless condition

    original_name_with_modifier = [original_name, modifier].join('--')
    [original_name, original_name_with_modifier].join(' ')
  end
end
