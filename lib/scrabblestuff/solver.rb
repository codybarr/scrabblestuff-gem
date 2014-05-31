module Scrabble
  class Solver
    # The name of the file to use as a word dictionary. This file can be any
    # file that contains a list of words, one word per line.
    # @word_file_name = File.dirname(__FILE__) + "/../../assets/words.txt"
    attr_accessor :words, :trie

    # Reads in the words.txt file and returns an array containing all of the words
    # in that file.
    #
    # Used by other methods

    def initialize
      word_file_name = File.dirname(__FILE__) + '/../../assets/wwf.txt'
      @words = File.read(word_file_name).split("\n").map(&:downcase)
      @trie = Scrabble::Trie.new

      @words.each do |word|
        @trie << word.chomp
      end
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

    def find(letters, options = {})
      @trie.find(letters)
    end
  end
end
