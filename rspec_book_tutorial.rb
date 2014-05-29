require 'rubygems'
require 'rspec'

#rspec does not appear to be giving any feedback that I would like it to

class Book
end

describe Book do
	before :each do
		@book = Book.new "Title", "Author", :category
	end
	
	describe "#new" do
		it "returns a new book object" do
			@book.should be_an_instance_of  Book
		end
		
		it "takes three parameers and returns a book object" do
			book = Book.new "Title", "Author"
			
			book.should_not be_an_instance_of Book
		end
	end
end
