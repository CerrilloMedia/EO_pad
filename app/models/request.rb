class Request < ApplicationRecord
  has_many :availabilities, inverse_of: :request, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true, reject_if: :no_dates
  # accepts_nested_attributes_for :availabilities, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :client_name, :body, :subject
  validates_length_of :body, within: 10..300, message: "message body must be between 10 and 300 characters"
  validates_length_of :client_name, within: 2..30

  enum status: [:active, :completed]

  default_scope { order(created_at: :desc) }

  private
  #
  def no_dates(attributes)
    puts "Checking blank nested attributes"
    if attributes.select { |k,v| k.downcase.include? "date" }.values.join.empty? && attributes.select { |k,v| k.downcase.include? "time" }.values.join.empty?
      puts "values for date and dateTime"
      self.errors.add(:availability, "must contain at least one date")
      attributes[:_destroy] = "1"
      # return true
    end
    puts "before false return"
    false
    puts "after false return"
  end

end
