module ApplicationHelper

  def get_date(date)

  end

  def get_timeout
    current_user.timeout_in if current_user
  end

  def alert_for(flash_type)
    # hash[key_as_sym]
    {
        :success => 'alert-success',
        :error => 'alert-damage',
        :alert => 'alert-warning',
        :notice => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

end
