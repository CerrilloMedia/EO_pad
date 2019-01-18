class Request < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  has_many :comments, inverse_of: :request, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true

  has_many :availabilities, inverse_of: :request, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true,
                                reject_if: :all_blank, limit: 4

  validates_presence_of :user_id, :recipient_id, :body
  validates_presence_of :client_name, :unless => :subject?, message: "%{value} required if no subject supplied"
  validates_presence_of :subject, :unless => :client_name?, message: "%{value} required if no client name supplied"
  validates_length_of :body, within: 10..300, message: "message body must be between 10 and 300 characters"
  validates_length_of :subject, within: 5..300, message: "message subject must be between 10 and 300 characters"
  validates_length_of :client_name, within: 4..40, :unless => :subject?, message: "must be longer than 2 characters"

  enum status: [:active, :completed]

  default_scope { order(created_at: :desc) }

  scope :completed, -> {where(status: 'completed')}
  scope :active, -> { where(status: 'active') }
  scope :my, -> { where("user_id = recipient_id") }
  scope :assigned, -> { where("user_id != recipient_id") }
  scope :to_user, ->(user=nil) { where(recipient: user)}
  scope :from_user, ->(user=nil) { where(user: user)}

  def participants(*args)
    args.each do |user|
      return true if self.user == user || self.recipient == user
    end
    false
  end

end
