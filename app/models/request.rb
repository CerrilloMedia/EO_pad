class Request < ApplicationRecord
  has_many :availabilities, inverse_of: :request, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true,
                                reject_if: :all_blank, limit: 4

  validates_presence_of :client_name, :body, :subject
  validates_length_of :body, within: 10..300, message: "message body must be between 10 and 300 characters"
  validates_length_of :client_name, within: 2..30

  enum status: [:active, :completed]

  default_scope { order(created_at: :desc) }

end
