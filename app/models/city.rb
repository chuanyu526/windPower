# encoding: utf-8
class City < ActiveRecord::Base
  attr_accessible :name, :province_id
  belongs_to :province
  has_many :county

  def self.info(name)
    #temp_name = name
  	#if name[name.length-1]!= '市'
    #  temp_name=name+'市'
    #end
  	#city = self.find_by_name(temp_name)
  	#if city
    #	province = city.province
    #	return [province.name, city.name]
  	#end
    cities = self.where(["name LIKE :tag", {:tag => "%#{name}%"}])
    if cities.size == 1
      province = cities[0].province
      return [province.name, cities[0].name]
    elsif cities.size > 1
      arr = ["Possible(city)"]
      cities.each do |city|
        province = city.province
        arr << [province.name,city.name]
      end
      return arr
    end
  end
end
