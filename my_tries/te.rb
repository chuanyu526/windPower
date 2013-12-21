f = File.open("./db/Provinces.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		print a[3]
	end
end
f.close
f = File.open("./db/Cities.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		print a[3]
		print a[5]
		puts ""
	end
end
f.close
f = File.open("./db/Districts.xml")
f.lines.each do |line|
	if line =~ /ID=/
		a=line.split("\"")
		print a[1]
		print a[3]
		print a[5]
		puts ""
	end
end
f.close