#Heap

#maxheap satifies "if Y is a child of X, then val(X) >=val(y)
#a heap is a related to a binary tree

class MaxHeap
	#this means that you can access and change classinstace.heapsize .arraysize, and array
	#it would be better if you could only change the heapsize and arraysize through special functions
	#currently if you wanted to set it to something unreasonable, you could.
	attr_accessor :heapsize, :arraysize, :array
	
	def initialize(array)
		@array = array
		@arraysize = array.length
		@heapsize = array.length
		
		#the array is heaped, starting from the last element down to the first.
		#this may "heapify" too much, may really need floor(@size/2) downto 1
		((@arraysize-1)/2..1).each{ |index| 
		maxHeapify(array,index) 
		}
	end
	
	def maxHeapify(index) 		
		#it started out with "array" also being a variable, but I took this out, and replaced the 'array's with "@array"s
		#this should make it so that it calls on the object itself, and finds the array, and then modifies the @array in place

		#given the index of the parent, left and right are the indices of the children
		left= left(index)
		right = right(index)
		
		#this determines which index has the higher value of parent + children
		#find the max of the parent and left child
		if left < @heapsize && @array[left] >@array[index]
			max = left #if left is bigger than parent
		else
			max = index #this happens if k>l or if there are no children
		end
		#if r child exists, compare it with the left child, or the top
		if right < @heapsize && @array[right] > @array[max]
			max = right
		end
				
		#sifts the smaller items down the the tree
		if max !=index 
			#switch
			temp = @array[index]
			@array[index] = @array[max]
			@array[max] = temp
			maxHeapify(max)
		end

	end
	
	#left and right children
	def left(index)
		2*index + 1
	end
	def right(index)
		2*index + 2
	end
	
	#parent
	def parent(index)
		(index-1)/2
	end
	
	#buildMaxHeap only needs to be down on the first half, because all of the single leaves below that are children of these 
	#and included in the calculations of maxHeapify
	#heapsize rather than array, because sometimes you don't want to affect the things at the end of the line
	def buildMaxHeap(start = (@heapsize/2-1),finish = 0)
		#why count down and not up?  (count up would be like 7 + 5 +3 +2 +1, up would be like 1 + 1 +2 +1 + 2 ? )
		(start).downto(finish) do |index|
			maxHeapify(index)
		end
	end
	
	#when inserting, you need to heapify the data up or down.
	def insert(data, index)
		#initial insertion
		firstarray = @array[0..index]
		secondarray = @array[index+1..@array.length]
		@array = firstarray + data + secondarray
		
		
		#is there a faster way to do this?
		buildMaxHeap
		#if data <= @array[parent(index)]
		#	maxHeapify(index)
		#else
		#	#it would be nice to have a function that says "max heapify the parent if it needs it, else move upwards" which is recursive
		#end
		
	end
	
	
	def delete(index)
		firstarray = @array[0..index-1]
		secondarray = @array[index + 1..@array.length]
		@array = firstarray + secondarray
		
		#put things into order again ??faster way???
		buildMaxHeap
	end
end

#tests for a heap

#it might be pretty interesting to see what sort of tests there are
=begin
test = MaxHeap.new([1,4,3,27,18,5,2,9,8,10])
puts test.arraysize
test.buildMaxHeap
puts test.array
test.delete(4)
puts test.array
=end

def heapsort(array)
	#create a heap from an array
	heap = MaxHeap.new(array)
	heap.buildMaxHeap
	
	#puts heap.array
	#puts "_____"
	#puts "array size = #{heap.arraysize}"
	
	(heap.arraysize).downto(2) do |i|
		#exchange  of largest data point with end of the array
		temp = heap.array[0]
		heap.array[0] = heap.array[i-1]
		heap.array[i-1] = temp
		
		#decrement size of the heap so that the last value stays in the array, but does not get sorted
		heap.heapsize -=1
		heap.maxHeapify(0)
		#puts "**____**"
		#puts "i is equal to #{i}"
	
		#puts heap.array
		#puts "**_~~_**"
	end
	puts heap.array
end

#testsort
aheap = MaxHeap.new([8,2,43,9,1,3,4,10])
aheap.buildMaxHeap
puts "original array"
puts aheap.array
x = aheap.array[0]

puts "heap array[0] = #{x}"
puts "heap length = #{aheap.arraysize}"
aheap.array[0] = aheap.array[7]
aheap.array[7] = x
puts "____exchange__"
puts aheap.array
puts "heapsize = #{aheap.heapsize}"
aheap.heapsize -=1
aheap.maxHeapify(0)
puts "after build max heap"
puts aheap.array

#exchange
y = aheap.array[0]
aheap.array[0] = aheap.array[6]
aheap.array[6] = y
aheap.heapsize -=1
aheap.maxHeapify(0)
puts ")))))"
puts aheap.array

z = aheap.array[0]
aheap.array[0] = aheap.array[5]
aheap.array[5] = z
aheap.heapsize -=1
aheap.maxHeapify(0)

q = aheap.array[0]
aheap.array[0] = aheap.array[4]
aheap.array[4] = q
aheap.heapsize-=1
aheap.maxHeapify(0)
puts "02920349"
puts aheap.array

heapsort([20,92,78,54,67,43,40,55,76,5,74,22,63])

class PriorityQueue
	
	def initialize(array)
		@heap = MaxHeap(array)
	end
	
	def Maximum
		@heap.array[0]
	end
	
	def ExtractMax
		if @heap.heapsize < 1
			puts "heap underflow"
		end
		#extract max
		max = @heap.array[0]
		@heap.array[0] = @heap.array[@heap.heapsize-1]
		@heap.heapsize -=1
		@heap.maxHeapify(0) #maxheapify starting from the new first 
		return max
	end	
	
	def parent(index)
		(index-1)/2
	end
	
	def heapIncreaseKey(index, key)
		#oops check
		if key < @heap.array[index]
			puts "error: new key is smaller than current key"
		end
		#change the key
		@heap.array[index] = key
		#reorder the priorities until everything is in the correct key order
		while index > 0 && @heap.array[parent(index)] < @heap.array[index]
			#exchange
			temp = @heap.array[index]
			@heap.array[index] = @heap.array[parent(index)]
			@heap.array[parent(index)] = temp
			#keep exchanging the value with the key until it is first or the parent key is larger.
			index = Parent(index)
		end
	end
	
	def maxheapinsert(key)
		@heap.heapsize +=1
		@heap.array[@heap.heapsize-1] = -Float::INFINITY
		self.heapIncreaseKey(@heap.heapsize-1,key)
	end
	
end