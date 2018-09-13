class AddRecipientToRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :recipient, foreign_key: true
  end
end
