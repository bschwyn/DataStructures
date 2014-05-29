#main functions
#insert (push and insert) both done
#delete *done
#search *done
#print *done
#reverse #done!!

#things to test
#size changes correctly with different types of inputs
#initializing
#tail changes w/ deletion, initialization, insertion

#known errors:
#spat operator push goes in opposite direction

class Node
	attr_accessor :data, :next
	
	def initialize(data)
		@data = data
	end
end

class RecList
	attr_reader :size
	
	def initialize(data = nil)
		if data == nil
			@size = 0
		else
			node = Node.new(data)
			@size = 1
			@head = @tail = node
		end
	end
	
	def head
		@head.data
	end
	
	def tail
		@tail.data
	end
	
	def print #header #iterative recursion
		puts "{"
		current = @head
		printIter(1, current)
		puts "}"
	end
	
	#the "iter" is totally unnecessary
	def printIter(iter,current)
		if current == nil
			return
		else
			puts current.data
			current = current.next
			printIter(iter += 1,current)
		end
	end
	
	
	
	def rec_print(current = @head)
		puts current.data
		if current.next == nil
			return
		else
			rec_print(current.next)
		end
	end
	
	def push(data) #insert at beginning
		node = Node.new(data)
		node.next = @head
		@head = node
		@size +=1
		if @tail == nil
			@tail = node
		end
	end
	
	def pushArray(array)
		array.each { |elem| push(elem) }
	end
	
	#This seems to go in ... opposite order as pushArray???
	def push2(*items) #splat operator
		items.each {|elem| push(elem)}
	end
	
	def insert(data,n,current = @head) #recursive insert
		if n==0
			push(data)			
		elsif n ==1
			node = Node.new(data)
			node.next = current.next
			current.next = node
			if node.next==nil
				@tail = node
			end
			@size +=1
		elsif n > 1 && n<=@size
			insert(data,n-1,current.next)
		else
			puts "error: incorrect n"
		end
	end
	
	def delete(n, current = @head)
		#error with tail
		if n==0
			@head = @head.next
			@size -= 1
			
		elsif n==1
			current.next=current.next.next
			
		elsif n>1 && n< @size			
			delete(n-1,current.next)
			@size -=1
			
		else
			puts "Error: n is not in scope"
		end
	end
	
	def search(data, current = @head)
		if current ==nil
			false
		elsif data == current.data
			true
		else
			search(data,current.next)
		end
	end
	
	def reverse(current = @head, previous = nil)
		if current == nil
			@head = previous
			return
		else
			forward = current.next
			current.next = previous
			reverse(forward, current)	
		end
	end
end

letters = RecList.new
letters.push("a")
letters.push("b")
letters.push("c")
#puts letters.size
#letters.print
#letters.rec_print

#array = ["x","y","Z"]
#letters.pushArray(array)

#letters.rec_print
#letters.print
#letters.push2(5)
#letters.push2([3,"x"])
#letters.print

letters.insert("bob",2)
letters.insert("xyz",0)
#letters.rec_print2
#puts "tail"
#puts letters.tail
letters.insert("asldkfj",5)
#letters.print
#letters.tail
#puts letters.head
#puts "_____________________"
#puts "search"
#puts letters.search("bob")
#puts letters.search("z")
#puts "_____________________"

puts "size = #{letters.size}"
letters.print
puts "delete"
puts letters.tail
letters.delete(5)
letters.print
#puts "___________"
#letters.print
#puts "reverse"
#letters.reverse
#letters.print

#another way of writing if statments for recursive print
def rec_print_original(current = @head)
	puts current.data
	rec_print(current.next) unless current.next == nil
end


puts "______________"
new = RecList.new("sally")
puts new.head
