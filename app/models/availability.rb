class Availability < ApplicationRecord

  belongs_to :request

  validate :minimum_attributes

  private

  def minimum_attributes

    if times_no_dates
      # return an error if no dates are inputed but times have been
      request.errors.add(:availability, "must contain at least a start or end date")
      false
    elsif all_blank_on_update
      # erase any empty requests from the DB if they have already persisted to the database
      mark_for_destruction
    else
      true
    end
  end

  def times_no_dates
    (startTime? || endTime?) && ( date.nil? && endDate.nil?)
  end

  def all_blank_on_update
    startTime.nil? && endTime.nil? && date.nil? && endDate.nil? || attributes[:_destroy]
  end

end
