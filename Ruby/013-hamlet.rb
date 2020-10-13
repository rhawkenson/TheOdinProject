require 'open-uri'

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
File.open("hamlet.txt", "w") { |file| file.write(open(url).read) }

File.open("hamlet.txt", "r") do |file|
  file.readlines.each_with_index do |line, idx|
    puts line if idx % 42 == 41
  end
end