require 'matrix'

module Anagram
  @@zeros = 26.times.collect {0}
  
  def self.to_vector(word)
    array = @@zeros.dup
    word.each_byte { |x| array[x-65] += 1}
    Vector[*array]
  end

  def self.two_word_anagrams_of(string)
    s = string.upcase
    target = to_vector(s)
    target_array = target.to_a

    vec_hash = {}
    ret = []

    open('dictionary_full.txt','rb').each do |word|
      word.chop!

      bad = false
      word.each_byte do |x|
        if target_array[x-65] == 0
          bad = true
          break
        end
      end
      next if bad

      vec = to_vector(word)
      diff = target - vec
      if others = vec_hash[diff]
        others.each do |other_word|
          ret << "#{other_word} #{word}".downcase
        end
      end
      (vec_hash[vec] ||= []) << word
    end

    ret
  end
end
