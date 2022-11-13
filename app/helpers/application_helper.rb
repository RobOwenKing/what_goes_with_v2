module ApplicationHelper
  def format_time(time)
    time.strftime("#{time.day.ordinalize} %b \'%y, %H:%M")
  end
end
