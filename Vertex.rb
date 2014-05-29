#LinkedList
#Array
#Node for LinkedList
load 'linked_list.rb'

class Vertex
	attr_accessor :data
	
	def initialize(data = nil, storage = List.new())
		@data = data
		@storage = storage
	end
	
	def addNeighbor(anotherVertex)
		@storage.insertBeginning(anotherVertex)
	end
	
	#depth first search
	def printAll(structure)
		puts @data
		s = structure
		s.push(@storage.deleteBeginning)
		 while top
			top.printAll
			s.push(@storage.deleteBeginning)
			top = s.pop
		end
		#return
	end
	
	def printBFS
		puts @data
		q = Queue.new
		q.push(@storage.deleteBeginning)
		 while top
			top.printAll
			q.push(@storage.deleteBeginning)
			top = q.pop
		end
		#return
		
end


a = Vertex.new("A")
root = a
b = Vertex.new("B")
c = Vertex.new("C")
d = Vertex.new("D")

a.addNeighbor(c)
a.addNeighbor(b)
b.addNeighbor(d)

root.printAll(Stack.new) # DFS: A B D C
root.printAll(Queue.new) # BFS A C B D

