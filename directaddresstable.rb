class DirectAddressTable
	
	attr_reader :array
	
	def initialize
		@array = []
	end
	
	def insert(key,data)
		@array[key] = data
	end
	
	def delete(key)
		@array[key] = nil
	end
	
	def search(data)
		index = 0
		until @array[index] == data
			index +=1
		end
		@array[index]
	end

end

hash = DirectAddressTable.new

hash.insert(3,"blue")
hash.insert(4,"caa")
hash.insert(10,"poo")
hash.insert(7,"bird")
puts hash.array

puts hash.search("bird")

puts "__________"
x = [1,2,3]
print x
x[15] = nil
y = [1,2,3]
puts x+y


puts (1000 % 23)

puts (Math.sqrt(5)-1)/2