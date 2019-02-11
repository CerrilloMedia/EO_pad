module ChartsHelper

  def get_expiring_requests(arr, days=7)
    # get an array of requests each with it's most recent availability if any from within the timeframe passed
    arr.active.map { |r|
      [ r, get_availability(r,days) ]
    }
    .sort_by {|r,date|
      # sort requests by most recent expriation date
      date
    }.map { |r,date|
      {'request' => r, 'date' => date }
    }

  end

  def is_within_range?(a, days)
      a > Time.now && a < Time.now + days.days
  end

  def get_availability(request,days)
    return nil unless request.availabilities
    request.availabilities.select { |a|
      ( a.endDate && is_within_range?(a.endDate, days) ) || ( a.date && is_within_range?(a.date,days) )
    }.map {|a|
      a.endDate || a.date
    }.compact.first

  end

end
