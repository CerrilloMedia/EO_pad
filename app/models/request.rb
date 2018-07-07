class Request < ApplicationRecord

  validates_presence_of :client_name, :body
  # validates_length_of :subject, within: 3..30, message: "subject must be between 3 and 30 characters"
  validates_length_of :body, within: 10..300, message: "message body must be between 10 and 300 characters"
  validates_length_of :client_name, within: 2..30

  enum status: [:active, :completed]

  default_scope { order(created_at: :desc) }
end
