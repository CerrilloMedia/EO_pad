ActiveAdmin.register User do

permit_params :email, :current_sign_in_at, :sign_in_count, :requests, :tasks

# ActiveAdmin.register Request do
#   belongs_to :user
# end
# disable comments
config.comments = false

# filter do |f|
#   f :email
#   f :current_sign_in_at
#   f :sign_in_count
# end

index do
  selectable_column
  id_column
  column :email
  column :current_sign_in_at
  column :sign_in_count

  # controller do
  #   def scoped_collection
  #     super.includes(:requests)
  #   end
  # end
  column 'Active Requests' do |user|
    user.requests.active.count
  end
  column 'Completed Requests' do |user| user.requests.completed.count end
  column 'Total Requests' do |user| user.requests.count end


  column "Active Tasks"       do |user| user.tasks.active.count end
  column "Completed Tasks"    do |user| user.tasks.completed.count end
  column 'Total Tasks' do |user| user.tasks.count end

  actions
end


end
