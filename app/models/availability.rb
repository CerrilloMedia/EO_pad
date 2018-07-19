class Availability < ApplicationRecord
  # include ActiveModel::Validations
  belongs_to :request

  validate :minimum_attributes
  # validates :date, format: { with: /(\d{1,2}\/){2}\d{4}/, on: [:create, :update] }
  # validates :endDate, format: { with: /(\d{1,2}\/){2}\d{2,4}/, on: [:create, :update] }

  private

  def minimum_attributes
    puts "checking minimum attributes"
    if (startTime? || endTime?) && ( date.nil? && endDate.nil?)
      request.errors.add(:availability, "must contain at least a start or end date")
      false
    else
      true
    end
  end

end
