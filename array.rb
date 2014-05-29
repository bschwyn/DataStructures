#The goal of this project is to learn about objects and data structures
#The first data structure that I will implement is a linked list.

#actually, it looks like I may start out with Arrays

#issuees with arrays in Ruby:
#in certain apps it is desirable to index array elements starting with a non-zero base index. 
#However in Ruby, every array has a base index of 0.
#sometimes only non-negative indices are required
#in such a case, negative indices will not be detected and lead to errors

#one way to address these is to extend the Array class
#define a new instance attribute @baseIndex, and redefine a number of Array class methods
#The @baseIndex attribute is a Fixnum which records the lower bound for array indices.

class Array

	alias_method :init, :initialize #this means that init does the same thing as initialize
	
	def initialize(size = 0, baseIndex = 0) #default value of zero
		init(size, nil) #what is this init function?
		@baseIndex = baseIndex #instance variable that is changed for each array
	end
end



#new = Array.init(3,2) # I thought that alias_method would make it so that I can use init outside?

newarray = Array.initialize(3,2) #error???

#I guess init isn't a defined function yet?

class Array2
	
	alias_method :getitem, :[] #how does ruby not get all screwed up when you do something equivalent of "function1function2" ? totally weird. 
	alias_method :setitem, :[]=
	
	protected :getitem, :setitem #what does this mean?