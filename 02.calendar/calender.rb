require "date"
require "optparse"
require "paint"

class Calender

  def initialize(year: Date.today.year, month: Date.today.month)
    @year = year
    @month = month
  end  
  def generate
    firstday = Date.new(@year, @month, 1).wday
    lastday = Date.new(@year, @month, -1).day
    top = Date.new(@year, @month).strftime("%m月 %Y")
    day_of_week = [ "日", "月", "火", "水", "木", "金", "土" ]
    
    puts top.center(20)
    puts day_of_week.join(" ")
    print "   " * firstday

    (1..lastday).each {|date|
      if Date.new(@year, @month, date) == Date.today
        print Paint[date, :white, :black].to_s.rjust(2) + " "
      else 
        print date.to_s.rjust(2) + " "
      end
      firstday = firstday + 1
      if firstday %7 == 0
        print "\n"
      end
    }
  end
end
params = ARGV.getopts("y:", "m:")
calender = Calender.new(
  year: params["y"] &.to_i || Date.today.year, 
  month: params["m"] &.to_i || Date.today.month
)
calender.generate
