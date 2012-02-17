require 'haversine'
require 'poscvt'

positions = [
  {
    :date => "2012-02-04",
    :gmt_hour => 8,
    :north_degrees => 21,
    :north_minutes => 51,
    :west_degrees => 37,
    :west_minutes => 58
  },
  {
    :date => "2012-02-05",
    :gmt_hour => 8,
    :north_degrees => 21,
    :north_minutes => 33,
    :west_degrees => 38,
    :west_minutes => 53
  },
  {    
    :date => "2012-02-06",
    :gmt_hour => 9,
    :north_degrees => 21,
    :north_minutes => 05,
    :west_degrees => 39,
    :west_minutes => 58
  },
  { 
    :date => "2012-02-07",
    :gmt_hour => 9,
    :north_degrees => 20,
    :north_minutes => 47,
    :west_degrees => 40,
    :west_minutes => 57
  },
  { 
    :date => "2012-02-08",
    :gmt_hour => 9,
    :north_degrees => 20,
    :north_minutes => 33,
    :west_degrees => 42,
    :west_minutes => 00
  },
  { 
    :date => "2012-02-09",
    :gmt_hour => 9,
    :north_degrees => 20,
    :north_minutes => 12,
    :west_degrees => 43,
    :west_minutes => 10
  },
  { 
    :date => "2012-02-10",
    :gmt_hour => 9,
    :north_degrees => 19,
    :north_minutes => 56,
    :west_degrees => 44,
    :west_minutes => 18
  },
  { 
    :date => "2012-02-11",
    :gmt_hour => 9,
    :north_degrees => 19,
    :north_minutes => 33,
    :west_degrees => 45,
    :west_minutes => 27
  },
  {
    :date => "2012-02-13",
    :gmt_hour => 9,
    :north_degrees => 19,
    :north_minutes => 05,
    :west_degrees => 47,
    :west_minutes => 22
  },
  {
    :date => "2012-02-14",
    :gmt_hour => 9,
    :north_degrees => 18,
    :north_minutes => 54,
    :west_degrees => 48,
    :west_minutes => 19
  },
  {
    :date => "2012-02-15",
    :gmt_hour => 9,
    :north_degrees => 18,
    :north_minutes => 39,
    :west_degrees => 49,
    :west_minutes => 9
  },
  {
    :date => "2012-02-16",
    :gmt_hour => 9,
    :north_degrees => 18,
    :north_minutes => 14,
    :west_degrees => 49,
    :west_minutes => 58
  }
]

canaries_x = 28.1
canaries_y = -15.4
barbados_x = 13.1
barbados_y = -59.616667

puts total_distance = Haversine.distance(canaries_x,canaries_y,barbados_x,barbados_y).to_miles



daily_progress = []
positions.each_with_index do |position,index|
  unless index == 0
    current_position = PosCvt.new("#{position[:north_degrees]}.#{position[:north_minutes]}.00,-#{position[:west_degrees]}.#{position[:west_minutes]}.00").decimal_degrees.split(',')
    previous = positions[index-1]
    previous_position = PosCvt.new("#{previous[:north_degrees]}.#{previous[:north_minutes]}.00,-#{previous[:west_degrees]}.#{previous[:west_minutes]}.00").decimal_degrees.split(',')
    distance = Haversine.distance(current_position[0].to_f,current_position[1].to_f,previous_position[0].to_f,previous_position[1].to_f).to_miles
    puts "Distance covered #{position[:date]}: #{distance}"
    daily_progress << distance
  end
end

#we don't have data from < Feb 4, so the distance from the Canaries until Feb 4th needs to be added

start_record = PosCvt.new("#{positions[0][:north_degrees]}.#{positions[0][:north_minutes]}.00,-#{positions[0][:west_degrees]}.#{positions[0][:west_minutes]}.00").decimal_degrees.split(',')
daily_progress << Haversine.distance(canaries_x,canaries_y,start_record[0].to_f,start_record[1].to_f).to_miles

completed = daily_progress.inject(:+)
remaining = total_distance - completed
puts total_distance
puts completed
puts remaining
