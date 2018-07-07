module ApplicationHelper

  def get_date(date)

  end

  def alert_for(flash_type)
  {
      :success => 'alert-success',
      :error => 'alert-damage',
      :alert => 'alert-warning',
      :notice => 'alert-info'
  }[flash_type.to_sym] || flash_type.to_s
end

end
