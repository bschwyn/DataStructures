#binary search tree
#

require "test/unit"
require "rubygems"
require "pry"


class Node
    attr_reader :key
    attr_accessor :data, :parent, :left, :right
    
    def initialize(key, data=nil)
        @left = nil
        @right = nil
        @parent = nil
        @key = key
        @data = data
    end
end


class BinaryTree
    attr_accessor :root
    
    def initialize(root_key = nil,data = nil)
        if root_key == nil
            @root = nil
            @size = 0
        else
            @root = Node.new(root_key,data)
            @size = 1
        end
    end
    
        def insert(key, data=nil)
        node = Node.new(key, data)
        trailing_pointer = nil #parent of pointer
        pointer = self.root
            
            
        while pointer != nil && node.key != pointer.key
            trailing_pointer = pointer
            #check if newNode goes to the left or right of the root 
            #trace path downward until there is an open place for the new node
            if node.key < pointer.key
                pointer = pointer.left                
            else
                pointer = pointer.right
            end
        end
        #set parent of newnode 
        node.parent = trailing_pointer
        
        #reset connections for a replacement
        if pointer != nil
            if pointer.left != nil
                pointer.left.parent = node
            end
            if pointer.right != nil
                pointer.right.parent = node
            end
            node.left = pointer.left
            node.right = pointer.right
        end    
            
        #set children of parent node
        if trailing_pointer == nil
            self.root = node
        
        elsif node.key < trailing_pointer.key
            trailing_pointer.left = node   
        else
            trailing_pointer.right = node
        end
    end
    
    
    #totallly should NOT work
    def search(key, source_key = self.root.key)       
        if key < source_key
            search(key,root.left.key)
        elsif key == source_key
            return key
        else
            search(key,root.right.key)
        end
    end
    
    def search2(key,source_key,pointer = self.root) #source_key = self.root.key
           
        if source_key < pointer.key 
            search2(key,source_key,pointer.left)
        elsif source_key == pointer.key
            _get(key,pointer)
        else
            search2(key,source_key,pointer.right) 
        end
    end    
    
    def _get(key, source = self.root)
    #returns node
        if key < source.key
            _get(key,root.left)
        elsif key == source.key
            return source
        else
            _get(key,root.right)
        end
    end 
        
    def minimum(node)
        while node.left.key !=nil
            node = node.left.key
        end
    end
    
    
    #totally should not work because of ignoring difference between nodes and keys
    def delete(node)
        def transplant(u, v)
            #replaces subtree rooted at node u with subtree rooted at v
                            #update connection pointing down to v
            if u.parent == nil #is u the root? Make it v
                self.root = v
            elsif u == u.parent.left #is u a left child
                u.parent.left = v #u's parent becomes v's parent
            else
                u.parent.right = v #u is a right child
            end
             
            #update connection pointing up from v
            if v !=nil
                v.parent = u.parent
            end
        end
    
        parent = node.parent
        if node.left == nil #goes for case when node.right == nil also
            transplant(node, node.right)
        elsif node.right==nil
            transplant(node, node.left)
        else
            y = minimum(node.right)
            if y.parent != node
                transplant(y,y.right)
                y.right = node.right
                y.right.parent = y
            end
            transplant(node,y)
            y.left = node.left
            y.left.parent = y
        end
    end         
    
    def inorder_tree_walk(node)
        if node != nil
            inorder_tree_walk(node.left)
            puts(node.key)
            inorder_tree_walk(node.right)
        end
    end
    
    def preorder_tree_walk(node) #goes down leftmost pathways first
        if node != nil
            puts(node.key)
            preorder_tree_walk(node.left)
            preorder_tree_walk(node.right)
        end
    end
    
    def print(node) #is there a way that I could make a tree walk that returns nodes, and a print function that takes nodes and prints them, so that you could do 'print - preorder' or 'print - postorder'?
        puts node.key
    end
    
    def postorder_tree_walk(node)
        if node != nil
            puts(node.key)
            postorder_tree_walk(node.right)
            postorder_tree_walk(node.left)
        end
    end
    
    def is_bst(node = self.root, min = -500, max = 500)
        if node.key == nil
            true
        elsif node.key < min || node.key > max
            false
        else
            is_bst(node.left, min, pointer.key)
            is_bst(node.right,node.key,max)
        end
    end
 end           
    
            
class TestBinaryTree <Test::Unit::TestCase
    def test_initialize_empty
    
        y = BinaryTree.new()
        assert_equal(y.root,nil)
        #is that a problem? do I need something saying "don't ask for a key right now?"
    end
    
    def test_initialize_key_data
               
        x = BinaryTree.new(1,"data")
        
        #internal tests
        assert_equal(x.root.key,1)
        assert_equal(x.root.data,"data")
        assert_equal(x.root.parent,nil)
        assert_equal(x.root.left, nil)
        assert_equal(x.root.right, nil)    
        
    end
    
    def test_insert
        
        tree = BinaryTree.new()
        tree.insert(5)
        assert_equal(tree.root.key,5)
        
        #internals
        tree.insert(4)
        assert_equal(tree.root.left.key,4)
        assert_equal(5,tree.root.left.parent.key)
        tree.insert(6)
        assert_equal(tree.root.right.key,6)
        assert_equal(tree.root.right.data,nil)
        assert_equal(5, tree.root.right.parent.key)
        
        #externals
        #assert_equal(tree.search(5,5),5)
        #assert_equal(tree.search(5,4),4)
        #assert_equal(tree.search(rootnode,6),rightnode)
              
    end
    
    def test_insert_data
        tree = BinaryTree.new()
        tree.insert(5,"frog")
        tree.insert(4,"turtle")
        tree.insert(6,"toad")
        assert_equal(tree.root.data,"frog")
        assert_equal(tree.root.left.data,"turtle")
        assert_equal(tree.root.right.data,"toad")
        
        z = BinaryTree.new()
        z.insert(5,"BladeRunner")
        assert_equal(z.root.data,"BladeRunner")
        z.insert(5,"Akira")
        assert_equal(z.root.data,"Akira")
        z.insert(7,"Totoro")
        z.insert(3,"Star Wars")
        z.insert(4,"Jar Jar's Night Out")
        z.insert(6,"Catch 22")
        z.insert(3,"Star Trek")
        assert_equal(z.root.left.data,"Star Trek")
        assert_equal(z.root.left.right.data,"Jar Jar's Night Out")
        assert_equal(z.root.left.left,nil)
        assert_equal(z.root.left.right.parent.data,"Star Trek")
        assert_equal(z.root.left.parent.data,"Akira")
     
    end
        
    
    def test_search_single_insert
    #create tree w/ 16 elements
    #log_2 16 = 4
        
        btree = BinaryTree.new()
        #nvm assert_equal(btree.search(12,nil),nil)
           
        btree.insert(12)        
        assert_equal(btree.search(12), 12)
    end
    
    def test_search_multiple_insert   
        
        btree = BinaryTree.new()
        
        btree.insert(5)
        assert_equal(btree.search(5),5)
        assert_equal(btree.search(5,5),5)
        btree.insert(18)
        assert_equal(btree.search(18),18)
        #assert_equal(btree.search(18,5),18)
        #assert_equal(btree.search(18,18),18)
        btree.insert(2)
        #assert_equal(btree.search(2,5),2)
        assert_equal(btree.search(2),2)
        #assert_equal(btree.search(2,2),2)
        btree.insert(9)
        assert_equal(btree.search(9),9)
        #btree.insert(15)
        #assert_equal(btree.search(15),15)
        #btree.insert(19)
        #btree.insert(17)
        #btree.insert(1)
        #btree.insert(3)
        #btree.insert(7)
        #btree.insert(11)
        #btree.insert(8)
        #btree.insert(111)
        #assert_equal(btree.search),15)        
    #    assert_equal(btree.search(12,10000),nil)
        #some way to test log n?
        #some way to test in_order_tree_walk?
    end
    
    def test_is_btree
        
        btree = BinaryTree.new()
        
        btree.insert(12)
        btree.insert(5)
        btree.insert(18)
        btree.insert(2)
        btree.insert(9)
        btree.insert(15)
        btree.insert(19)    
        btree.insert(17)
        btree.insert(1)
        btree.insert(3)
        btree.insert(7)
        btree.insert(11)
        btree.insert(8)
        btree.insert(111)
        
        assert_equal(btree.is_bst(12),true)
       #btree.inorder_tree_walk(node12)
    end
end
    
