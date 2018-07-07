class AddClientToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :client_name, :string
  end
end
