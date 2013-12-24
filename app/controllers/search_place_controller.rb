# encoding: utf-8
class SearchPlaceController < ApplicationController

  include SearchPlaceHelper

  def index
  end

  def search
  	#1/0 #use to see the params in error page
  	# not allow search only for one charactor
  	if params[:name].length<2
  		return @result = "Input more charactor!"
  	end
    results = search_a_location(params[:name])
    @province_result = results[0]
    @city_result = results[1]
    @county_result = results[2]
  end

end
