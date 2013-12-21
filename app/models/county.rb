# encoding: utf-8
class County < ActiveRecord::Base
  attr_accessible :city_id, :name
  belongs_to :city

  def self.info(name)
    counties = self.where(["name LIKE :tag", {:tag => "%#{name}%"}])

  	if counties.size == 1
  		city = counties[0].city
  		province = city.province
  		return [province.name, city.name, counties[0].name]
    elsif counties.size > 1
      arr = ["Possible(county)"]
      counties.each do |county|
        city = county.city
        province = city.province
        arr << [province.name,city.name,county.name]
      end
      return arr
  	end

  end
end
