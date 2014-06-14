
#This is a hash table class
#it uses open addressing to address collisions
#the hash function is a double hash

require "test/unit"

class HashTable
	attr_reader :array, :size, :num_elements
	
	#initialize array and array size
	def initialize(size=0)
		@array = []
		@size = size
		@num_elements = 0
		if size >0
			@array[size-1] = nil
		elsif size < 0
		    raise "Error: size must be >= 0"
		end
	end
		
	def insert(key, value, count=0)
	#the insert function computes an index based off of the key value, and then inserts a key-value pair
	#if a collision occurs, it recursively calls itself with a different count value
	#the count changes the computed index
	
		#rehash if it starts getting pretty full
		if @num_elements == 3*@size / 4
			self.resize(2)
		end
				
		#I need a special value for delete
		#Should I use a regular expression? No---that is for matching two thingies.
		#just reserve something
		#try a singleton
		if value == "DELETE" #Delete.new ? 
			raise "Error: DELETE is a special value"
		end
	
		#converts different types of keys into integers
		hash = self.key_to_int(key)
		
		#calculates an index from the key integer with a hash
		index = self.double_hash(hash,count)
		
		#inserts key or use recursion to find open spot
		if count <= @size
			if @array[index]==nil #|| @array[index]=="DELETED"
				@array[index] = [key,value]
				@num_elements +=1
			elsif #key already in use, assign new value
			    @array[index][0]==key
			    @array[index] = [key,value]
			else #index filled, find new index
				insert(key, value, count+1)
			end
		else
			raise "Error: Hash table overflow" #write a test that makes this error #???#? should have a resize
		end
	end
	

	
	def resize(scale_factor)
	    #creates a new array that is bigger or smaller
	    @size = (@size*scale_factor).floor
	    @new_array = []
	    @new_array[@size-1] = nil
	    
	    #go through old array, look at keys and values, and rehash them with a new size
	    #for every element in the array
	        #check if pair or nil or delete
	        #if deleted, don't do anything
	        #if nil don't do anything
	        #if pair
	            #get key
	            #calculate new index w/ new array size
	            #insert key / value at new index in new array
	    pairs = @array.select{|element| element !=nil && element !="DELETE"} #make an array of key-value pairs
	    
	    pairs.each {|element| #go through the key-value pairs and insert them into new array
	        key = element[0]
	        value = element[1]
	            
	        def smallinsert(key,value,count=0)
	            intkey = self.key_to_int(key)
	            index = self.double_hash(intkey,count)
	            if @new_array[index]==nil
		            @new_array[index] = [key,value]
			    else
				    smallinsert(key,value, count+=1)
			    end
            end
            smallinsert(key,value)
	    }
        @array = @new_array
	end
	
	def []=(key,value)
		#alternate insert
		self.insert(key,value)
	end
	 
	def search(key,count = 0) #stop searching when you hit a nil
		#searches for key, returns value
		
		#computes integer from non-integer keys
		intkey = self.key_to_int(key) #key to hash #doubleHash is to Index???
		#computes index
		index = self.double_hash(intkey,count)
		
		#returns value or searches again
		if count <= @size
		    #nothing at search location
		    if @array[index]==nil
		        nil
		    #return the value being searched for if found
			elsif @array[index][0]==key
				return @array[index][1]
			#run search again
			else
				search(key,count+1)
			end
	    #search can't hit every index and not hit a nil because then table would be full
	    #if the index jumps are cyclic group then it will skip nils
		else
			nil #?should this "happen naturally?" error?
		end		
	end
	
	def [](key)
		#alternate search
		self.search(key)
	end
	
	def print
		#prints array and key/value pairs
		@array.each { |pair|
			if pair == nil
				puts nil
			else
				x = pair.join(" : ")
				puts x
			end
		}
	end
	
	def delete(key,count=0)
		#compute index
		intkey = key_to_int(key)
		index = self.double_hash(intkey,count)
		
		#change value to DELETE or keep looking
		if count <= @size
			if @array[index][0]==key
				@array[index]="DELETE"
				@num_elements -=1
				if @num_elements <= @size/4
				    self.resize(0.5) #cut array size in 2
				end
			else
				delete(key,count +1)
			end
		else
			raise "Error: key not found"
		end		
	end
	
	#creates hashes out of of keys
	def key_to_int(key)
		if key.is_a? String
			newkey = self.string_to_int(key)
		elsif key.is_a? Integer
			newkey = key
		elsif key.is_a? Float
			newkey = key.numerator
		end
	end 
	
	def string_to_int(string)
	    if string.is_a? String
		#for every character in string"
		#convert character to ASCII value
		#add to accumulator
		#return sum mod some number
		    if string == ""
		        sum =0
		    else
		        character_array = string.chars
		        sum = 0
		        character_array.map{ |c|
		    	#c to ascii value
		        	sum += c.ord
		    	    }
		        sum % @size
		    end
		else
		    raise "Error: string to Int not a string"
		end
	end
		
=begin
	def linearProbe(key,index)
		(self.hash(key) +index) % @size 
	end
	
	def quadraticProbe(key,index)
		c1 = 23
		c2 = 13
		(self.hash(key)+c1*index + c2*index) % @size 
	end
=end
 	
	def double_hash(key,count)
		if key.is_a? Integer# && (count.is_a? Integer)) && count >=0
		    def hash1(key)
			    key % @size 
		    end
		
		    def hash2(key)
			    1+(key % (@size - 1))
		    end
		
		    #double hash
		    (hash1(key) + count * hash2(key)) % @size 
		else
		    raise "Error: double hash"
		end
	end
	
	
end

class Delete
end

#Unit tests

class TestHashTable <Test::Unit::TestCase
    def test_initialize
        hash = HashTable.new(100)
        assert_equal(100,hash.size)
        assert_equal(hash.size,hash.array.length)
        
        hash0 = HashTable.new()
        assert_equal(0,hash0.size)
        assert_equal(hash0.size,hash0.array.length)
        #hashm = HashTable.new(-1)
        #assert_raise(hashminus =HashTable.new(-1))
    end
    
    def test_doublehash
        hash = HashTable.new(7)
        x=hash.double_hash(7,0)
        y = hash.double_hash(7,1)
        assert_equal(x,0)
        assert_equal(y,2)
        
        #e1= hash.double_hash(7,0.5)
       
    end
    
    def test_string_to_int
        hash = HashTable.new()
        assert_equal(hash.string_to_int(""),0)
        #assert_raise regarding not strings
    end
    
    def test_insert      
        #insert should return error when table is full
        #array should contain key/value pair
        #insert something with same key should replace that key
        #insert multiple things
        
        
        hash = HashTable.new(10)
        
        #insert a value
        hash.insert(14213,"value")
        #does the array have the value in it somewhere?
        x = hash.array.include?([14213,"value"])
        assert_equal(x,true)
        #number of elements increased by the proper amount
        assert_equal(hash.num_elements,1) 
        
        #does inserting a value with the same key replace the value?
        hash.insert(14213,"value 2")
        pairs = hash.array.select{|element| element}
        assert_equal(pairs.length,1) #replace
        assert_equal(pairs[0][1],"value 2") #same value?
        assert_equal(hash.num_elements,1) #still 1?
        
        #does some sort of resizing happen?
        (1..8).each{ |k| hash.insert(k,"asdf 20 #{k*23}")}
    
    end
    
    def test_search
        hash = HashTable.new(10)
        #can it find an inserted value?
        hash["key"]="value"
        assert_equal(hash["key"],"value")
        
        #does it return nil when key not found?
        assert_equal(hash.search("nokey"),nil)   
        
        
    end
    
    def test_delete
        hash = HashTable.new(10)
        hash.insert(3,"value")
        hash.delete(3)
        assert_equal(hash.num_elements,0)   
        assert_equal(hash.search(3),nil)
        assert_equal(hash.size,5)
    end
    
    def test_insert_delete
        hash = HashTable.new(10)
        hash.insert("bla bla","DELETE")
        #assert_raise(
    end
end


array = [1,2,nil,nil,nil,5]
puts array.size

puts "sdf"
puts x= array.select{|asd| asd==Integer}
puts "afsdf"


=begin

size = 75
hash = HashTable.new(size)
if hash.array.size == size
	puts "hash array size = input size"
end



#that looks reasonable...

for k in 1..10 do
	puts hash.double_hash(2,k)
end
puts  "____"



hash.insert("testin3g","    ere is no value!")
hash.insert("poo","poop")
hash.insert("foo","foopper")
hash["Foo"]="Foo value"
hash.insert("13.04 string","13.04 string")
hash.insert(13.04,13.04)
hash.insert(12.98, 12.98)
hash["key"]="Value"


for i in 1..3 do
	for k in 1..10 do
		hash[k]=[k*i]
	end
end

hash.print

puts "________"
hash.search("poo")
hash.search(1)
puts "numer elements = #{hash.num_elements}"


puts "------asdfdkfjdfa------"
x = hash.array.select{ |elem| elem}
puts x
puts "asdfasdfasdfasdfasdfaasdfasdfasdfasdfasdfasdf"
y = x.select{ |asdf| asdf[0]}
y[0]

hash2 = HashTable.new(10)
hash2.insert(14213,"value")
x = hash2.array.include?([14213,"value"])
               
#hash2.insert(14213,"value 2")
pairs = hash2.array.select{|element| element}
puts "))))))))))"
puts pairs


       
        #assert_equal(pair, [14213,"value 2"])


# hash.resize
#hash.print
=end

hash = HashTable.new(10)
hash.insert(1,"two")
hash.insert(2,"three")
hash[5]="ten"
hash[23]=23
hash.delete(1)
puts hash.array

