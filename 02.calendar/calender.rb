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
    
    puts %w(日 月 火 水 木 金 土).join(" ")
    
    first_wday = Date.new(@year, @month, 1).wday
    print "   " * first_wday

    last_day = Date.new(@year, @month, -1).day
    (1..last_day).each do |date|
      if Date.new(@year, @month, date) == Date.today
        print "\e[37m\e[40m#{date.to_s.rjust(2)}\e[0m" + " "
      else 
        print date.to_s.rjust(2) + " "
      end
      if Date.new(@year, @month, date).saturday?
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
