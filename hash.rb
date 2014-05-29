#Hash table

class Hash
	attr_reader :array
	
	def initialize(key, value, size)
		#m is the hash size
		@array = []
		@size = size
		if size > 0
			@array[size] = nil
		end
		
		@array[self.h(key)] = [value]
	end
	
	#assuming key is a random number between 0 and 1....
	#or just a number, because it doesn't actually matter that much
	#what the hash function is right now
	def h0(k)
		(@size*k).floor
	end
	
	def h(k)
		(k * (Math.sqrt(5)-1)/2  % 1).floor
	end
	
	def insert (key, value)
		#there is probably a better way to do this
		if @array[self.h(key)] == nil
			@array[self.h(key)] = [value]
		else
			chain = @array[self.h(key)]
			chain.push(value)
		end
	end
	
	def search(value)
		 index=0
		chain = @array[index]
		until chain.include?(value) do
	end
			