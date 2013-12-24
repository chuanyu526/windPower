# encoding: utf-8
class SearchStationController < ApplicationController

  include SearchStationHelper

  def index
  end

  def search
  	#use the station name to find location, most stations use the place name as their station name
  	@search_term = params[:name]
  	result = search_a_location(refine_search_term(@search_term))
  	# if we can not find anything, use Google search
  	if empty_result?(result)
  		#get raw Google search result
  		@search_term = find_item(params[:name])
  		#search against our location database
  		result = filter_search(@search_term)
  	end
    @province_result = result[0]
    @city_result = result[1]
    @county_result = result[2]
  end
end
