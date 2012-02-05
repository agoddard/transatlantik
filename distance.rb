require 'haversine'
require 'poscvt'

a = PosCvt.new('21.51.00,-37.58.00').decimal_degrees
b = PosCvt.new('21.33.00,-38.53.00').decimal_degrees

#TODO format for Haversine.distance
puts a #21.85, -37.96666666666667
puts b #21.55, -38.88333333333333

puts Haversine.distance(21.85,-37.96666666666667,21.55,-38.88333333333333).to_mi # 62.34736444259356
