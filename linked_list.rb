#homework
	#look for more errors, make code more robust
	# reverse a linked list
	#insert more than one thing at a time. (be able to convert an array into a linked list)

class Node
	attr_accessor :data, :next
	def initialize(data)
		@data = data
	end
end

class List
	attr_accessor :head
	attr_reader :tail, :size #don't want that to change
	
	def initialize(data = nil)
		@head = Node.new(data)
		@tail = nil #possibly nnode?
		if data ==nil
			@size =0
		else
			@size = 1
		end
	end
	
	#O(1)
	def insertBeginning(data) #push
		node = Node.new(data)
		node.next = @head
		@head = node
		@size +=1
	end
	
	def print
		puts "{"
		currentNode = @head		
		while currentNode.next != nil
			puts currentNode.data
			currentNode = currentNode.next
		end
		puts "}"
	end
	
	def deleteBeginning #pop
		popped = @head.data
		@head = @head.next
		@size-=1
		return popped
	end
	
	def deleteNth(n)
		count = 0
		currentNode = @head
		while count < n
			currentNode = @head.next
			count += 1
		end
		currentNode.next= currentNode.next.next
		@size -=1
	end
	
	def insertAfterNth(value, n) #with index of (a,b,c) as (1,2,3) #does not work with n 
		if n > 0
			count = 0
			currentNode = @head
			while count < n-1
				currentNode = currentNode.next
				count += 1
			end
			insert = Node.new(value)
			insert.next = currentNode.next
			currentNode.next = insert
		elsif n==0
			insertBeginning(value)
		elsif n < 0 || (n>@size)
			puts "ERROR: cannot insert. n must be >=0 and <size"
		end
		@size+=1
	end
	
	
	def search(value) #return true or false. recursive?
		currentNode = @head
		until currentNode.data == value
			currentNode = currentNode.next
		end
		currentNode.data
	end
	
	def size
		currentNode = @head
		count = 0
		until currentNode.data == nil
			currentNode = currentNode.next
			count+=1
		end
		@size = count
		@size
	end
	
	def insertEnd(value)
		insertAfterNth(value,@size)
		@size +=1
	end
end

# Only run the following code when this file is the main file being run
# instead of having been required or loaded by another file
if __FILE__==$0
  # Find the parent directory of this file and add it to the front
  # of the list of locations to look in when using require
  $:.unshift File.join(File.dirname(__FILE__),'..')      

letters= List.new
letters.insertBeginning("a")
letters.insertBeginning("b")
letters.insertBeginning("c")

puts "size"
puts letters.size

letters.print
puts "\n\n"

popped = letters.deleteBeginning
letters.print
puts "\npopped =#{popped}"

puts "\n\n"
letters.insertBeginning("c")
letters.insertBeginning("d")
letters.insertBeginning("e")
letters.print


puts "\n\ndeleteNth"
letters.deleteNth(3)
letters.print

puts "\n\ninsertNth"
letters.insertAfterNth("bzzt",1)
letters.print


puts letters.head=="b"
puts letters.head.data=="b"
puts letters.head.next.data=="b"
puts letters.head.next.next.data=="b"
puts letters.head.next.next.next.data=="b"
puts letters.head.next.next.next.next.data=="b"
puts letters.head.next.next.next.next.next.data==nil


found = letters.search("b")
puts found

letters.insertEnd("end") #cool error that appeared when I commented out a line! now fixed.
letters.print
end