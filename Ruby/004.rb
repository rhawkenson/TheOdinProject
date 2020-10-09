require "open-uri"
def count_any_tags(url, tag)
   pattern = /<#{tag}\b/
   page = open(url).read
   tags = page.scan(pattern)
   puts "The site #{url} has #{tags.length} #{tag} tags"
end

url = "http://www.nytimes.com"
tags = ["a", "div", "img"]
tags.each do |tag|
   count_any_tags(url, tag)
end
