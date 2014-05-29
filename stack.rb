
#the node class is the "box" when you visually represent a list.
#it has data, and an arrow to the next node
class Node
	attr_accessor :data, :next
	def initialize(data)
		@data = data
	end
end

#The "ListyStack" is a stack made out of a linked list
# The stack is FIFO, or First-In, First-Out.
#The difference between it and my earlier linked list is that it does not have an insert function
#only push and pop

class ListyStack
	attr_accessor :head
	attr_reader :tail, :size #don't want that to change
	
	#A stack is initialized with or without data
	def initialize(data = nil)
		@head = Node.new(data)
		@tail = nil
		if data==nil
			@size = 0
		else
			@size = 1
		end
	end
	
	#O(1)
	def push(data) #push
		node = Node.new(data)
		node.next = @head
		@head = node
		@size +=1
	end
	
	#O(n)
	def print
		puts "{"
		currentNode = @head		
		while currentNode.next != nil
			puts currentNode.data
			currentNode = currentNode.next
		end
		puts "}"
	end
	
	#O(1)
	def pop
		if @size ==0
			puts "ERROR: stack already empty"
		else
			top= @head.data
			@head = @head.next
			@size -= 1
			top
		end	
	end
	
end
