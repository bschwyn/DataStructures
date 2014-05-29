#A linked list has nodes, which contain data and a pointer
#The list object contains functions which put data into nodes and switch the pointers around

#this is a combination of linked list and rec_linked_list that has all of the functions
	#initialize
	#head
	#tail
	#push
	#map push with splat operator
	#pop
	#delete
	#pushArray
	#iterative print
	#recursive print
	#insert
	#recursive insert
	#delete
	#recursive delete
	#search

#require unit testing framework


class Node
	#define instance variables, or those variables that can be accessed with Node.instancevariable => instancevariable
	#these can be rewritten also with node.instancevariable = newvalue (attr_reader and writer)
	attr_accessor :data, :next
	def initialize(data)
		@data = data
	end
end

class List
	#in the list class I  need several different methods
	#search
	#insert
	#delete
	#you should always be able to change the head without any trouble
	attr_accessor :head
	#however, the tail and the size should be immutable, but you still want to know what they are.
	attr_reader :tail, :size
	
	#to initialize the list, we need a function that specifically says "initialize"
	def initialize(data = nil)
		#for initializing a list, there is a node, and two pointers
		#@head is the box containing the data, however just having the data itself would not work because the head needs to always point to the top box.
		
		if data == nil
			@size = 0
		else
			@size = 1
		end
		node = Node.new(data)
		@head = @tail = node
	end
	
	#insert beginning
	# !?this works for arrays but goes backwards
	def push(data)
		node = Node.new(data)
		node.next = @head
		@head = node
		@size +=1
	end
	
	#this pushes each element in an array into the list, going from the first to the last
	def pushArray(array)
		array.each{ |elem| push(elem)}
	end
	
	def pushAnything(*items)
		items.each{ |elem| push(elem)}
		@size +=items.size
	end
		
	
	#no such thing as a recursive push---it's just doing one thing, not multiple
	
	def head
		if @head.data == nil
			nil
		else
			@head.data
		end
	end
	
	def tail
		if @tail.data ==nil
			nil
		else
			@tail.data
		end
	end
	
	#print1 and print2 put a space when a list is initialized without a value.
	#this is probably related to the "nil" value
	
	def print1
		puts "{"
		current = @head
		while current != nil
			puts current.data
			current = current.next
		end
		puts "}"
	end
	
	def print2
		puts "{"
		current = @head
		printIter(current)
		puts "}"
	end
	
	def printIter(current)
		if current ==nil
			return
		else
			puts current.data
			current = current.next
			printIter(current)
		end
	end
	
	#this printIter2 does not work, though I am not sure why
	def printIter2(current)
		while current !=nil
			puts current.data
			current = current.next
			printIter2(current)
		end
		return
	end
	
	#where n =0 is the first place (similar to an array)
	def insert(data,n,current = @head)
		if n ==0
			push(data)
		elsif n==1
			node = Node.new(data)
			node.next = current.next
			current.next = node
			
			current = @head.next
			insert(data,n+=1,current)
			#possibly some code about changing the tail here
			@size +=1
		elsif n>1 && n <=@size
			insert(data,n-1,current.next)
		else
			puts "error: incorrect n"
		end
	end
	
	#I remember enough about lists, recursion and stuff now that I'm going to move on
	
			
			
end


#Unit Tests
#test empty list first

empty = List.new
if empty.size== 0
	puts "empty size passed"
else
	puts "Error: size"
end

if empty.head == nil
	puts "empty list head test passed"
else
	puts "Error: empty list head"
end

if empty.tail == nil
	puts "empty list head tail passed"
else
	puts "Error: empty list tail"
end

#from empty list to nonempty

empty.push("a")
if empty.size==1
	puts "empty to nonempty size ok"
	if empty.head == "a"
		puts "push a to empty ok"
		if empty.tail ==nil
			puts "tail still nil"
		else
			puts "error with tail"
		end
	else
		puts "error with head after push"
	end
else
	puts "error with size"
end

#test push, push array, and print

list = List.new("a")
list.push("b")
list.push("c")
list.print1 #test print1 by looking at the output

puts list.size
puts list.size+3
list.pushArray(["d","e","f"])
puts list.size
if list.size == 6
	puts "push array size ok"
else
	puts "error with push array size"
end

list.print1
list.print2
puts "print1 and print2 ok"

list2 = List.new(5)
list2.pushAnything("a",["b","c"])
list2.print1

asdf = List.new
asdf.pushArray([1,2,3,4,5])
asdf.print1

#because the pushanything function uses the push method, and it goes through arrays backwards I need to check that component by itself.

pushtest = List.new(1)
pushtest.push(["a","b","c"])
pushtest.print1

