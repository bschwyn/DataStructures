#fix tail bugs
#new totally recursive linked list (insert, delete, search, print
#recursive insert (print first)
#initialize/insert array

#later, make a totally recursive linked list

class Node
	attr_accessor :data, :next
	def initialize(data)
		if data==nil
			raise "nil is not acceptible as data for Node"
		end
		@data = data
	end
end

class List
	attr_accessor :head
	attr_reader :tail, :size #don't want that to change
	
	def initialize(data=nil)
		if data ==nil
			@size =0
		else
			node = Node.new(data)
			@size = 1
			@head = node
			@tail = node
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
		current = @head
		while current != nil
			puts current.data
			current = current.next
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
		#update tail
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
		#do somehting about tail if at the end
		@size+=1
	end
	
	
	def search(value) #return true or false. recursive?
		currentNode = @head
		until currentNode.data == value
			currentNode = currentNode.next
		end
		currentNode.data
	end
	
	def insertEnd(value)
		#insertAfterNth(value,@size)
		new =Node.new(value)
		@tail.next = new
		@tail = new
		@size +=1
	end
	
	def reverse
		previous = nil
		current = @head
		while current != nil
			forward = current.next
			current.next = previous
			previous = current
			current = forward
		end
		@head = previous
	end
end
	

abc = List.new
abc.insertBeginning("a")
abc.insertBeginning("b")
abc.print
abc.reverse
abc.print

x = List.new('x')
puts x.print

