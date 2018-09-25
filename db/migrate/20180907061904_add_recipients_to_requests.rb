class AddRecipientsToRequests < ActiveRecord::Migration[5.2]
  def change
    # when using sqlite3, the following DID create a proper reference to the User within Requests.recipient.
    # add_reference :requests, :recipient, foreign_key: true

    # Not so much when changing DB to postgresql in order to push up to Heroku. Found
    add_reference :requests, :recipient, foreign_key: { to_table: :users }
  end
end
