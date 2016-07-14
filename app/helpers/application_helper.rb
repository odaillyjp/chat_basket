module ApplicationHelper
  def class_name_with_modifier(original_name, modifier, condition)
    condition ? [original_name, modifier].join('--') : original_name
  end
end
