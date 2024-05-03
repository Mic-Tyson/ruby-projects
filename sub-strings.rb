def substrings(string, dictionary) 
    dictionary.reduce({}) do |a, word| 
        word = word.downcase
        val = string.downcase.scan(word).count
        a[word] = val if val != 0
        a
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)
