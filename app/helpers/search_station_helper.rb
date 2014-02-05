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
      	pos = init_result.enum_for(:scan, /村|镇|市|县|自治州|自治县|岛|旗|草原|乡/).map    { Regexp.last_match.begin(0) }
      	pos.each do  |pos| 
       	   inter_result << init_result[pos-4, 5] + ' ' 
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
    	all_range = (0..search_term.size-1).to_a.combination(2).to_a
    	all_substrings = []

    	#find all substrings
    	all_range.each do |range|
    		all_substrings<<search_term[range[0],range[1]+1]
    	end

    	#search all substring untill get one result
    	all_substrings.each do |passible_place_name|
    		result = search_a_location(passible_place_name)
    		if not empty_result?(result)
    			break
    		end
    	end

    	return ["","",""] unless not empty_result?(result)
    	return result
   	end
end
