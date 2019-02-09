module ChartsHelper

  def get_expiring_requests(arr, days=7)
    # get an array of requests each with it's most recent availability if any from within the timeframe passed
    arr.active.map { |r|
      [ r, get_availability(r,days) ]
    }
    .delete_if {|a,b|
      # delete request if no availabilities found
      b.nil? }
    .sort_by {|a,b|
      # sort response first by endDate then by date
      [ b.endDate , b.date ]
    }.map { |r,a|
      {'request' => r, 'availability' => a }
    }

  end

  def is_within_range?(a, days)
      a > Time.now && a < Time.now + days.days
  end

  def get_availability(request,days)
    return nil unless request.availabilities
    request.availabilities.select { |a|
      ( a.endDate && is_within_range?(a.endDate, days) ) || ( a.date && is_within_range?(a.date,days) )
    }.sort_by! {|a|
      # first sort by endDate, then by startDate
      [a.endDate, a.date] }.first
  end

end
