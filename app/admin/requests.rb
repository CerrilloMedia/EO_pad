ActiveAdmin.register Request do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  # belongs_to :user
  # navigation_menu :user
  config.comments = true

index do
  column "from/to", class: 'text-center' do |request|
    if request.user != request.recipient
      [request.user.display_name(true),"->",request.recipient.display_name(true)].join(" ").html_safe
    else
      "self"
    end
  end
  column "type" do |request|
    request.user == request.recipient ? "To Do" : "Task"
  end
  column :created_at
  column :status do |request|
    request.completed? ? request.updated_at : "active"
  end
  column "timeframe" do |request|
    if request.completed?
      time_ago_in_words(request.updated_at - request.created_at)
    else
      time_ago_in_words(Time.new - request.created_at)
    end
  end
end



end
