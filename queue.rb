#you can make a queue out of a doubly linked list

#nodes have two pointers, next and previous, compared to a singly linked list
class Node
	attr_accessor :data, :next, :previous
	def initialize(data)
		@data = data
	end
end

class DoubleList
	#both head and tail are accessors as opposed to readers
	attr_accessor :head
	attr_accessor :tail
	
	def initialize(data = nil)
		@head =@tail =  Node.new(data)
		@head.next = @head.previous = @tail.next = @tail.previous = nil
	end
	
	def pushHead(data)
		node = Node.new(data)
		@head.previous = node #needs to come before change in head
		node.previous = nil
		node.next = @head
		@head = node
	end
	
	#O(1)
	def pushTail(data) #enqueue
		node = Node.new(data)
		@tail.next = node
		node.next = nil
		node.previous = @tail
		@tail = node
	end
	
	#O(1)
	def popHead #or Dequeue
		@head.next.previous = nil
		top = @head.data
		@head = @head.next
		return top
	end
	
	#O(1)
	def popTail
		@tail.previous.next = nil
		bottom = @tail.data
		@tail = @tail.previous
		return bottom
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
	

	def deleteNth(n)
		#this deletes a node by rearranging pointers
		count = 0
		if n >= 0
			#counting forwards when n =0 or more
			currentNode = @head
			while count < n
				currentNode = @head.next
				count += 1
			end
			currentNode.next.previous = nil
			currentNode.next= currentNode.next.next
		else
		#counting backwards from the end when n is negative
			currentNode = @tail
			while count < -n
				currentNode = @tail.previous
				count +=1
			end
			currentNode.previous.next = nil
			currentNode.previous = currentNode.previous.previous
		end
	end
	
	def insertNth(value, n)
		#insert by rearranging nodes
		count = 0
		if n >=0
			currentNode = @head
			while count < n+1
				currentNode = currentNode.next
				count += 1
			end
			insert = Node.new(value)
			currentNode.next.previous = insert
			insert.next = currentNode.next
			insert.previous = currentNode
			currentNode.next = insert
		else
			currentNode =@tail
			while count < -(n+1)
				currentNode = currentNode.previous
				count += 1
			end
			#if I had to do this once more I would make a method!
			insert = Node.new(value)
			currentNode.previous.next = insert
			insert.previous = currentNode.previous
			insert.next = currentNode
			currentNode.previous = insert
		end
			
	end
	
	def search(value)
		currentNode = @head
		until currentNode.data == value
			currentNode = currentNode.next
		end
		currentNode.data
	end
end

#one of the the things important to understand about queue's and stacks, is "BFS vs. DFS"
