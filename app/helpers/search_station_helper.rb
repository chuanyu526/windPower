# encoding: utf-8
module SearchStationHelper
	include SearchPlaceHelper
	#Get Google search result, parse the result
	def find_item query
		init_result = '' 
      	inter_result = '' 
      	search = Google::Search::Web.new do |search|
       	   search.query = query
      	end.each {|item| init_result << (item.title + item.content) }
      	init_result = init_result.gsub(/[^\p{Han}]/, '' )
        #search for locations
      	pos = init_result.enum_for(:scan, /镇|市|县|自治州|自治县|岛|旗|草原|乡/).map    { Regexp.last_match.begin(0) }
      	pos.each do  |pos| 
       	   inter_result << init_result[pos-4, 5] + ' ' 
      	end 

        pos = init_result.enum_for(:scan, /#{query}/).map    { Regexp.last_match.begin(0) }
        pos.each do  |pos| 
           inter_result << init_result[pos-8, 8] + ' ' 
        end


      	arr = inter_result.split (' ')
      	arr.collect! do |places| 
       	   places =  Tradsim::to_sim("#{places}") 
      	end 
      	freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        #return location that most often appears 
      	arr = arr.sort_by { |v| freq[v] }.last
      	#arr = arr.uniq 
     	 #final_result = [arr[-1],arr[-2],arr[-3]]
 	end

 	#delete "风电厂" keyword, only search for name
  	def refine_search_term(search_term)
   		return search_term.delete "风电厂"
 	end

 	#helper function use to check an empty result
 	def empty_result?(result)
 		if result==[] or result==["","",""] or result.nil?
 			return true;
 		end
 		return false
 	end

 	#seach_term is a string wich contains the place name we got from Google search, in this function
 	#we use while loop to sub out the string, looking for matching terms
  	def filter_search(search_term)
     	result = []
      sub_strings = []
      min_result = []
      #	all_range = (0..search_term.size-1).to_a.combination(2).to_a
    	#all_substrings = []
      i = search_term.size-2 
      j=2
      while   i > 1   do
         sub_strings << search_term[i , j]
         i -= 1 
         j += 1
      end 

   
     
      h = 0 
      k = 2    
      while   k < search_term.size - 1   do
         sub_strings << search_term[h , k]
         k += 1
      end 


  

    
    	#find all substrings
    	#all_range.each do |range|
    	#	all_substrings<<search_term[range[0],range[1]+1]
    	#end 

    	#search all substring untill get one result
      #min_result = search_a_location(sub_strings[0]) 
    	sub_strings.each do |passible_place_name|
    		result = search_a_location(passible_place_name)
        print result
        


        if empty_result?(min_result) 
          min_result  = result  
        #elsif min_result.size > result.size and ! empty_result?(result.size) 
        #  min_result = reuslt 
        end 

    	end


    	return ["","",""] unless not empty_result?(min_result)
    	return min_result
   	end
end
