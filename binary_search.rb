def binary_search(value,sorted_array)
    midpoint = (sorted_array.length-1)/2
    if value < sorted_array[midpoint]
     
        new_array = sorted_array[0..midpoint] 
        binary_search(value,new_array)  
       
    elsif value > sorted_array[midpoint]
        new_array = sorted_array[(midpoint+1)..-1]
        binary_search(value,new_array)  
    else
        puts "ding ding"
        return value
    end
end

y = [1,2,3,4,5,6,7,8,8,8,9,10,11,14,15,18,20,22,40,89,109,110,111]
 

 #why stack level too deep????   
puts y.map{|k| binary_search(k,y)}  

