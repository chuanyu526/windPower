# magic_coding: UTF-8
module SearchPlaceHelper

#require 'rubygems'
require 'google-search'
require 'enumerator'

  def search_a_location(search_term)
    province_result=""
    city_result=""
    county_result=""
    if search_term.nil? or search_term.length<=1
      return
    end

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
      province_info = Province.find_by_name(search_term)
      city_info = City.find_by_name(search_term)
      county_info = County.info(search_term)
      province_result = province_info.to_s
      city_result = city_info.to_s
      county_result = county_info.to_s
    end
    return [province_result,city_result,county_result]
  end

end
