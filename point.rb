#For practice with classes, here is a point class
#ended up using person class to do a more detailed study


class Point
	
	def initialize(x,y)
		@x, @y = x,y #need a better idea of why the @ signs
	end
	
	
	attr_reader :x, :y
	
	
	def distance(point)
		Math.sqrt((point.x - x)**2 + (point.y - y)**2)
	end
end

a_point= Point.new(1,2)
b_point = Point.new(3,12)

atob = a_point.distance(b_point)

puts atob