require "date"
require "optparse"

class Calender
  def initialize(year, month)
    @year = year
    @month = month
  end  
  
  def generate
    top = Date.new(@year, @month).strftime("%m月 %Y")
    puts top.center(20)
    
    puts "日 月 火 水 木 金 土"
    
    first_wday = Date.new(@year, @month, 1).wday
    print "   " * first_wday

    last_day = Date.new(@year, @month, -1).day
    
    (1..last_day).each do |day|
      current_date = Date.new(@year, @month, day)
      align_day = day.to_s.rjust(2)

      if current_date == Date.today
        print "\e[37m\e[40m#{align_day}\e[0m" + " "
      else 
        print align_day + " "
      end
      if current_date.saturday?
        print "\n" 
      end
    end
    print "\n"
  end
end

params = ARGV.getopts("y:", "m:")
calender = Calender.new(
  params["y"] &.to_i || Date.today.year, 
  params["m"] &.to_i || Date.today.month
)
calender.generate
