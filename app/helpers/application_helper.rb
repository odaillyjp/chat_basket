module ApplicationHelper
  def hiding_bem_class(class_name, condition)
    suffix = condition ? '--disabled' : ''
    [class_name, suffix].join
  end
end
