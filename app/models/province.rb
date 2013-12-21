# encoding: utf-8
class Province < ActiveRecord::Base
  attr_accessible :name
  has_many :city

  def self.info(name)
  	#temp_name = name
  	#if name[name.length-1]!= '省'
    #  temp_name=name+'省'
    #end
    provinces=self.where(["name LIKE :tag", {:tag => "%#{name}%"}])
    #found accurate province
    if provinces.size==1
    	return provinces[0].name
    #found possable provinces
    elsif provinces.size>1
    	arr = ["Possible(province)"]
    	provinces.each { |province| arr<<province.name}
    	return arr
    end
  end
end