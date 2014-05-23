module Scrabble
  module Solver
    # The name of the file to use as a word dictionary. This file can be any
    # file that contains a list of words, one word per line.
    # @word_file_name = File.dirname(__FILE__) + "/../../assets/words.txt"
    @word_file_name = File.dirname(__FILE__) + '/../../assets/wwf.txt'

    # Reads in the words.txt file and returns an array containing all of the words
    # in that file.
    #
    # Used by other methods

    def self.word_list
      @word_list ||= File.open(@word_file_name) do |file|
        file.readlines.map do |line|
          line.chomp
        end.delete_if do |line|
          line.length < 2
        end
      end

      @word_list.clone
    end

    # Gets an array of words that would fit the current board of Scrabble
    # tiles.
    #
    # Example:
    #
    #   Scrabble::Solver.words_for "there"
    #   # => An array of words that the tiles t, h, e, r, e could make.
    #
    #   Scrabble::Solver.words_for "there?"
    #   # => An array of words that the tiles t, h, e, r, e plus a blank tile
    #   #    could make.

    def self.words_for(letters, options = {})
      # splits the letters into lowercase array of individual letters
      letters  = letters.downcase.split(//)

      # cycles through the entire word list, returns a list of new words as long as they match the algorithm
      words = word_list.keep_if do |word|
        # Split the current dictionary word into an array of its letters.
        word = word.split(//)

        # cycles through each of the letters in our letters array
        letters.each do |letter|
          # if the letter is found...
          unless word.index(letter).nil?
            # delete the letter from the word, move to the next letter
            word.delete_at word.index(letter)
          end
        end

        # Only return the word if there are no remaining letters
        word.length == 0
      end

      # Filter only words that start with a specific sequence.
      if options[:starts_with]
        words.keep_if { |word| word.start_with? options[:starts_with] }
      end

      # Filter words that only end in a certain sequence.
      if options[:ends_with]
        words.keep_if { |word| word.end_with? options[:ends_with] }
      end

      # Fitler only words shorter than a given amount.
      if options[:shorter_than]
        words.keep_if { |word| word.length < options[:shorter_than].to_i }
      end

      # Filter words only longer than a given amount.
      if options[:longer_than]
        words.keep_if { |word| word.length > options[:longer_than].to_i }
      end

      # Filter words that contain a specific sequence at a given 1-based index.
      if options[:contains]
        # Generate a regex to match against the string. This regex will replace
        # question marks with dots, so that they match any character. This
        # gives the user a lot of power with the --contains --at combo.
        regex  = ''
        regex += ('^' + ('.' * (options[:at].to_i - 1))) if options[:at]
        regex += options[:contains].gsub('?', '.')
        regex  = Regexp.new regex
        words.keep_if do |word|
          word =~ regex
        end
      end

      return words
    end
  end
end
