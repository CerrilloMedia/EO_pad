
module RequestsHelper

  def format_date(date,short=nil)
    return if date.nil?
    time = Date.parse(date.to_s)
    time.strftime("%m/%d/%Y")
  end

  def format_time(time)
    return if time.nil?
    time = Time.parse(time.to_s)
    time.strftime("%I:%M %p")
  end

  def format_availability(a)
    date = [] <<  if a.date || a.endDate
                    if a.endDate.nil?
                      ["on",format_date(a.date)]
                    elsif a.date.nil?
                      ["before", format_date(a.endDate)]
                    else
                      ["between",format_date(a.date), "-", format_date(a.endDate)]
                    end
                  end

    time = [] <<  if a.startTime || a.endTime
                    if a.startTime.nil?
                      ["before", format_time(a.endTime)]
                    elsif a.endTime.nil?
                      ["after", format_time(a.startTime)]
                    else
                      ["between", format_time(a.startTime), "-", format_time(a.endTime)]
                    end
                  end

    joiner = "::" if date.count + time.count == 2
    [date,time].flatten.join(" ")
  end
end
