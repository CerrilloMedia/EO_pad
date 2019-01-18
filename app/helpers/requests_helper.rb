
module RequestsHelper

  def format_date(date,short=nil)
    return if date.nil?
    time = Date.parse(date.to_s)
    time.strftime("%-m/%-d")
  end

  def format_time(time)
    return if time.nil?
    time = Time.parse(time.to_s)
    time.strftime("%l:%M%p").sub!('M','').downcase
  end

  def format_availability(a)
    date = [] <<  if a.date || a.endDate
                    if a.endDate.nil?
                      ["on",format_date(a.date)]
                    elsif a.date.nil?
                      ["before", format_date(a.endDate)]
                    else
                      [format_date(a.date), "-", format_date(a.endDate)]
                    end
                  end

    time = [] <<  if a.startTime || a.endTime
                    if a.startTime.nil?
                      ["by", format_time(a.endTime)]
                    elsif a.endTime.nil?
                      ["after", format_time(a.startTime)]
                    else
                      [" from", format_time(a.startTime), "-", format_time(a.endTime)]
                    end
                  end

    joiner = "::" if date.count + time.count == 2
    [date,time].flatten.join(" ").html_safe
  end

end
