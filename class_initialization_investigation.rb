#It looks like I need to have a better understanding of how objects work in ruby.
#starting from a very simple class

class Person
	def initialize(x)
		@age = x
	end
end

#This has several components. The first thing, "class Person" creates a new class named "Person".
#the initialize function means that after [class name = Person].new you add a set of parenthesis and the initial values
# @age means that age is an "instance variable" and that you can do variable.age =>age or Person.age

#that can also be done this way:

Person2 = Class.new do
	def initialize(x)
		@age = x
	end
end

#Now, the only method that these classes have is an initialize method

#to make a person...
#In Python I would say: 
#jones = Person(43)

#in Ruby...

Ralph = Person.new(43)

#but I don't think there is any way for me to get the age back out, or to change Ralph's age.
#puts Ralph.age =>				 ERROR

#To get a person's age out I have to add

class Person3
	def initialize(int)
		@age = int
	end
	
	def age
		@age
	end
end

Sally = Person3.new(75)
puts Sally.age #This prints Sally's age

#I still can't change the age though.

class Person4
	def initialize(x)
		@age = x
	end
	
	def age
		@age
	end
	
	def age=(int)
		@age = int
	end
	
	def test=(a)
		@age = a
	end
end

Person4.new(23)
puts Person4.new(23).age
Zoe = Person4.new(23)
puts Zoe.age

#now to change Zoe ('age her')

Zoe.age = 24
puts Zoe.age

#I can also create a class without any initial values

class Person5
	def age
		@age
	end
	
	def age= (x) 
		@age = x
	end
end

#notes
#one thing to note is that while Ruby doesn't care about spaces in something like "Billy =Person.new", spaces do matter for a function name.
#I need to look up and see if foo= is something special. What about the method name foo=bar? 
#does = act like a character?
#if .age = calls the function  "age=" does .a ge= also work?
Zoe.age=25
#Zoe.a ge=26 =>				ERROR
#definitely something to look into.

Billy = Person5.new
Billy.age = 40
puts Billy.age

#Ruby has several methods already defined.
#attr_writer which is the same as "def age" 
#attr_reader same as "def age=(x)

#I have to check and see if the colon-variables-symbols are necessary, but so far I have seen them used with attr

class Person6
	def age
		@age
	end
	
	attr_writer :age
end

Ace = Person6.new
Ace.age = 7
puts Ace.age

#attr_accessor 
#Here I'm going to see what the symbol ":age" does
#as a symbol, it means that age will just refer to a set of numbers
#Scope is throughtout the entire program. Everywhere, age is the same.
#This does not mean that age in other programs is now acting as the symbol age defined here.

class Person7
	attr_accessor :age
	
end
puts "object ids"
puts "age".object_id
puts  :age.object_id

#that gives me an idea
#I tried adding these methods
	#def object
	#	:age.object_id 	or  @:age.object_id or age.object_id	#This does not work because....
	#end
	
	#def object
	#	puts :age.object_id 		This successfully prints out the object id (trivially) but still gives an error of "undefined method"
	#end

#Calli = Person7
#puts Calli.object

#none of that worked

#class Person8
#	attr_accessor age
#end

#nope

#class Person8
#	def initialize(int)
#		@age = int
#	end
#	
#	attr_accessor age
#end

#Well, the point that I can get is:
#attr_accessor is a method that seems to only work with symbols

#Another question I have is.... is Initialize a name that  is required?

class Person8
	def init(int)
		@age = int
	end
	
	attr_accessor :age
end

#Jordan = Person8.new(17) =>		 ERROR
Jordan = Person8
#Jordan.init(17) =>			ERROR

#This was a good exercise, I'm now much more comfortable with the syntax and scope.
#Things to learn in the future: How are these rules affected with sub classes?


#NORMAL PERSON

class Dude
	def initialize(int)
		@age = int
	end
	
	attr_accessor :age
end

#I want to know how other functions are accessed

class Person9
	def initialize(int)
		@age = int
	end
	attr_accessor :age
	
	def multipleAge(a)
		@multiple = a*@age
	end
end

puts "function testing"
Kayla = Person9.new(24)
puts Kayla.multipleAge(5)

class Person9
	def split
		@age/2
	end
end

Donald = Person9.new(40)
puts Donald.split