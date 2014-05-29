#linked list

#composed of groups of nodes

#node is composed of data and a reference

#class node
#	attr_accessor :data, :next_node

#Only data needs to be initialized.
#*********************************************************************************************
class Node
	attr_accessor :data, :next
	def initialize(data)
		@data = data
	end
end

oneNode= Node.new("one")
twoNode = oneNode.next = Node.new("two")
threeNode = twoNode.next = Node.new("three")

#another way

a= Node.new(1)
b= a.next = Node.new(2)
c = a.next.next = b.next = Node.new(3)
d = a.next.next.next = b.next.next = c.next = Node.new(4) #I have to see if this is going to cause any errors,
												#but I assume that reassigning equal things to other equal things
												#should not cause any issues
#one thing we can note is that this allows us to create a bunch of separate nodes.

x = Node.new(12)
y = Node.new(2323)
z = Node.new(55)

# and then we can connect them any way we feel like.

x.next = y
y.next = z

#even in circular pattern

x.next = z
y.next = x
z.next = y

#lets try it
#puts "cycle"
#puts x.next.next.next.next.next.next.data => 12
#totally cool!


#*****************************************************************************************

#Ideally, there should be an object called a list
#when you first make one, it should be empty, or have some initial value.
	#empty list may mean no nodes, or only sentinel nodes
	#just like you can have an empty array, you should be able to have an empty list
#head should be a pointer which points to the first data point
#head should be nil for an empty list
#tail should be a pointer to Nil

#at first I started making many List classes. However, to focus in on the questions I had, it's better to just look at init definitions


#I'm confused, so am going to list out the different init methods I made

def init1(firstNode = Node.new(data = nil))
	@head = firstNode
	@tail = nil
end
#init1 makes Node.new(data = nil) the default of firstNode, if you input List.new
#To make a different firstNode, you could input something like "init1(Node.new(25))
#since defaults occur when you don't put anything, it's not possible to have the default case occur at different values
#so... it should be (firstNode = Node.new(nil))

def init2(firstNode = Node.new(data = nil))
	@head = firstNode = Node.new(data = nil)
	@tail = firstNode.next = nil
end

#when adding a new node, something like this would happen:
#init(Node.new(3))
#@head = Node.new(3) = Node.new(data = nil)
#this seems like it would lead to problems. Why did it not?
	#no "data" variable to be detected
	#@head = Node.new(3) = Node.new(nil)? 
	# is this similar to x = 3 = 5? Why no error?
	#No. It is similar to x = y =3, which is the same as x = (y = 3)
	#so, firstnode is asigned the value Node.new(data =nil)
	#so whatever input of firstNode was completely ignored. BAD

#changing the nils
def init2_2(foo= Node.new(nil))
	@head = foo = Node.new(nil)
	@tail = foo.next = nil
end

def init3(data = nil)
	@head = foo= Node.new(data)
	@tail = foo.next = nil
end
#The big difference here is initializing the list with data rather than a node
#A big question here: Was a new node named "foo" created somewhere?				how are variables different from pointers? In NOT C
	#does initNode have a pointer that goes somewere to nil?
	#if it did exist, how could I access it?
	
#still problem of x=(y=3)
	
#How is this code different from

def init3_2(data = nil)
	@head = Node.new(data)
	@tail = nil
end

#or 

def init3_3(data = nil)
	@head = Node.new(data)
	@tail = @head.next = nil
end

#?
#note, that there are many ways to initialize something
	
#someone else's code:
#I don[t know why they did this, it seems wrong

def init4(head)
	raise "List4 must be initialized with a Node" unless head.is_a?(Node)
	@head = head
	@tail = head
end

#a take on that:
def init5(head)	
	raise "List4 must be initialized with a Node" unless head.is_a?(Node)
	@head = head
	@tail = nil
end
#init1 is the same as init5 w/ a default
#***********************************************************************************************
	
#After doing that analysis, let me show the surviving candidates:
def init1(firstNode = Node.new(nil)) #may want to have firstNode = nil instead			
	@head = firstNode
	@tail = nil
end
def init3_2(data = nil)
	@head = Node.new(data)
	@tail = nil
end
def init3_3(data = nil)
	@head = Node.new(data)
	@tail = @head.next = nil
end
#The difference between init1 and init 3_2 is initializing with nodes or data. It looks equivalent
#init 3_3 includes the extra information that @head.next is the tail. No problem there
#*******************************************************************************************

#Other than init, there are some other functions that would be good to add
#various names for different functions are: (some of them are repeated)
#insert/delete at begginning
#insert/delete at end
#"add"
#insert/delete in middle (insert after)
#push
#pop
#print



#this list is using data input rather than node input
#after inspection, I really don't think these are that different
class List2
	attr_accessor :head
	attr_reader :tail #don't want that to change
	
	def initialize(data = nil)
		@head = Node.new(data)
		@tail = nil
	end
	
	def insertBeginning(data)
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
end

words = List2.new
puts words.head ==nil #False. does not necessarily mean that this is wrong? #evidently not
puts words.tail == nil

words.insertBeginning("begat")
words.insertBeginning("Harley")
words.insertBeginning("janitor")
puts words.head
puts words.tail==nil
words.print


#it is interesting to note how the instance variables in ruby change the functions a little.
#otherwise I would have had to do something like "self.head"

class List
	attr_accessor :head
	attr_reader :tail #don't want that to change
	
	def initialize(head = nil)
		@head = head
		@tail = nil
	end
	
	def insertBeginning(node)
		puts node.data
		node.next = @head
		@head = node
		puts @head.data
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
end

puts "\n\n"
numbers = List.new
puts numbers.head ==nil
puts numbers.tail == nil

firstnumber= Node.new(3)
numbers.insertBeginning(firstnumber)
puts numbers.head==nil
puts numbers.tail==nil
secondNumber = Node.new(4)
third= Node.new(5)
numbers.insertBeginning(secondNumber)
numbers.insertBeginning(third)
d = Node.new(6)
de = Node.new(7)
numbers.insertBeginning(d)
numbers.insertBeginning(de)

puts "\n\n\n"
numbers.print
=begin
class List
	#has issues
	attr_accessor :head, :tail
	def initialize(firstNode = Node.new(data = nil))
		@head = firstNode
		@tail = nil
	end
end

puts "\nList1 class"
first_list = List.new(25) #=> bad. Should return an error if initializing thing is not a node
puts first_list.head
puts first_list.tail #=> returns blank space

#testing
first_list.head =Node.new(13)
puts first_list.head

class List2
	attr_accessor :head, :tail
	def initialize(firstNode = Node.new(nil))
		@head = firstNode = Node.new(data = nil)
		@tail = firstNode.next = nil
	end
end

puts "\nList2 class"
first_list2 = List2.new(Node.new(25))
puts first_list2.head # list2.head is an object
puts first_list2.tail #list2.tail is a nil
list2 = List2.new
puts list2.head #=.object thingy
puts list2.tail #=> nil


#alternatively



class List3
	attr_accessor :head, :tail
	def initialize(data = nil)
		@head = initNode = Node.new(data)
		@tail = initNode.next = nil 	#A big question here: Was a new node named "initNode" created somewhere?
							#does initNode have a pointer that goes somewere to nil?
							#if it did exist, how could I access it?
	end
end

puts "\nList3 class"
list3 = List3.new(30)
puts first_list.head #list3.head is an object
puts first_list.tail #list2.head is a nil.

#alternatively

class List4
	attr_accessor :head, :tail
#	def initialize(head)
#		raise "List4 must be initialized with a Node" unless head.is_a?(Node)
#		@head = head
#		@tail = nil
#	end
#end

=end
class List234
	attr_accessor :head, :tail
	def initialize(firstNode = Node.new(data = nil))
		@head = firstNode
		@tail = nil
	end
	
	def addNode(data)
		newNode = Node.new(data)
	end
end

class List24343
	attr_accessor :head, :tail
	def initialize(firstNode = Node.new(data = nil))
		@head= firstNode
		@tail = firstnode
	end
	
	def print
		current_node  = @head
		puts "{"
		while current_node != nil
			puts "#{current_node.data}"
			current_node = current_node.next
		end
		puts "}"
	end
end
#head--- points to first item
#__head__(just a pointer) ---> ( data pointer data pointer)--->(tail w/ data, pointer)---> Nil

# __head__ --->NULL
#__head__---->tail ----> NULL
#first_list.insert(Node.new(30))

#puts first_list.


# It should start with head.next = Nill, then when I add a new node,
#rewrite head.next to have point to the new node, have the new node point to null

#twoNode = oneNode.next = "two"
#puts oneNode.class # => Node
#puts twoNode.class # => string
#therefore twoNode LOOKS like it might be a node, but it is not.

#threeNode = twoNode.next("three")
#puts "threenode data is "
#puts threeNode.data
#fourNode = threeNode.next("four")
#fiveNode = fiveNode.next("five")

#While this has sort of made some connections between some things, they aren't *really* a thingy.
#what is actually going on here?
#oneNode, a variable, is assigned the value of an object, Node, with the instance variable @data = "one".
#oneNode is now 

class List1
	#when I think about it from a 'levels of abstraction' point of view, a list has a
	#head
	#tail ----actually does not need this, since tail is an empty node
	#nodes
	attr_accessor :head, :node
	
	#this seems like something where I actually need revision control
	
	#before implementing searching a list, insertion, and deletion, I just want to be able to make A list.
	# to do that, I need to:
	#add a node in one direction
	#add  data to the node in that direction
end

list1 = List1.new
list1.node= oneNode

# I would like to add multiple nodes, but this would have a structure of one object connected to all the other objects
#and then those connected to each other, like a wheel, with #list as the axel and the nodes as spokes. 



#tests to have:
	#empty node?
	#different data types
	