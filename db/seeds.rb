# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

f = File.open("./db/Provinces.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		#print a[3]
		Province.create(:name=>a[3])
	end
end
f.close
f = File.open("./db/Cities.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		#print a[3]
		#print a[5]
		#puts ""
		province = Province.find(a[5])
		province.city.create(:name=>a[3])
	end
end
f.close
f = File.open("./db/Districts.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		#print a[3]
		#print a[5]
		#puts ""
		city = City.find(a[5])
		city.county.create(:name=>a[3])
	end
end
