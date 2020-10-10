dictionary = [
  "below","down","go","going","horn","how","howdy","it","i",
  "low","own","part","partner","sit"]

def substrings(text, dictionary)
  clean_text = text.downcase.gsub(/[^a-zA-Z\s]/, '')
  result = Hash.new(0)
  clean_text.split.each do |substring|
    dictionary.each do |d|
      if substring.include?(d)
        result[d] += 1
      end
    end
  end
  puts result
end

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)