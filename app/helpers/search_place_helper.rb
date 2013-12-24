# magic_coding: UTF-8
module SearchPlaceHelper

#require 'rubygems'
require 'google-search'
require 'enumerator'

  def find_item query
      init_result = '' 
      inter_result = '' 
      search = Google::Search::Web.new do |search|
          search.query = query
      end.each {|item| init_result << (item.title + item.content) }
      init_result = init_result.gsub(/[^\p{Han}]/, '' )
      pos = init_result.enum_for(:scan, /村|镇|市|县|自治州|自治县|岛|旗|草原|乡/).map    { Regexp.last_match.begin(0) }
      pos.each do  |pos| 
          inter_result << init_result[pos-4, 4] + ' ' 
      end 
      arr = inter_result.split (' ')
      arr.collect! do |places| 
          places =  Tradsim::to_sim("#{places}") 
      end 
      freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      arr = arr.sort_by { |v| freq[v] }.last
      #arr = arr.uniq 
      #final_result = [arr[-1],arr[-2],arr[-3]]
   end

  def search_a_location(search_term)
    province_result=""
    city_result=""
    county_result=""

    #prioritize search
    if search_term[search_term.length-1]=='省'
      province_info = Province.info(search_term)
      province_result = province_info
    elsif search_term[search_term.length-1]=='市'
      city_info = City.info(search_term)
      city_result = city_info.to_s
    elsif search_term[search_term.length-1]=~/乡|县|村|区/
      county_info = County.info(search_term)
      county_result = county_info.to_s
    end

    #enhence search
    if province_result == "" and city_result == "" and county_result == ""
      province_info = Province.info(search_term)
      city_info = City.info(search_term)
      county_info = County.info(search_term)
      province_result = province_info.to_s
      city_result = city_info.to_s
      county_result = county_info.to_s
    end
    return [province_result,city_result,county_result]
  end

end
