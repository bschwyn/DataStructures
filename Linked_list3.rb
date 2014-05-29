class Node
	attr_accessor :data, :next
	def initialize(data)
		@data = data
	end
end

class List
	attr_accessor :head
	attr_reader :tail #don't want that to change
	
	def initialize(data = nil)
		@head = Node.new(data)
		@tail = nil
	end
	
	#O(1)
	def insertBeginning(data) #push
		node = Node.new(data)
		node.next = @head
		@head = node
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
	end
	
	def insertNth(value, n)
		count = 0
		currentNode = @head
		while count < n
			currentNode = @head.next
			count += 1
		end
		insert = Node.new(value)
		insert.next = currentNode.next
		currentNode.next = insert
	end
end

letters= List.new
letters.insertBeginning("a")
letters.insertBeginning("b")
letters.insertBeginning("c")

letters.print

popped = letters.deleteBeginning
letters.print
puts popped

puts "\n\n"
letters.insertBeginning("c")
letters.insertBeginning("d")
letters.insertBeginning("e")
letters.print

puts "\n\n"
letters.deleteNth(3)
letters.print

puts "\n\n"
letters.insertNth("bzzt",3)
letters.print
#other data structures