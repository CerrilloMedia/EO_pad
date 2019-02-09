class ChartsController < ApplicationController

  def get_requests_for_user
    sanitized_params = params.transform_values(&:to_i)
    user = sanitized_params[:user_id]

    user = User.find(user)
    days = sanitized_params[:days] || 7

    user_chart = []

    if current_user != user
      requests = user.requests.assigned.to_user(current_user)
      tasks = user.tasks.assigned.from_user(current_user)
    else
      requests = user.requests.assigned
      tasks = user.tasks.assigned
      todo = user.tasks.my
    end

    user_chart << {name: 'tasks', data: tasks.group_by_day(      :updated_at, last: days, format: '%m/%d').sum(:status)} if tasks
    user_chart << {name: 'requests', data: requests.group_by_day(:updated_at, last: days, format: '%m/%d').sum(:status)} if requests
    user_chart << {name: 'todo', data: todo.group_by_day(        :updated_at, last: days, format: '%m/%d').sum(:status)} if todo

    render json: user_chart
  end

  def update_expiring_tasks
    
  end

end
