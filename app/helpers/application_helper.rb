module ApplicationHelper
   def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-info"
    when :alert  then "bg-warning"
    when :error  then "bg-error"
    else "bg-success"
    end
  end
end
