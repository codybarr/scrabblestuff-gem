# trie.rb
# from https://gist.github.com/Sirupsen/6481936
module Scrabble
  class Solver
    attr_accessor :word, :nodes, :used, :all
   
    def initialize
      @word, @nodes = false, {}
    end

    def load_dictionary(word_file_name = File.dirname(__FILE__) + '/../../assets/words.txt')
      words = File.read(word_file_name).split("\n").map(&:downcase)

      words.each do |word|
        self.<< word.chomp
      end
    end
   
    def <<(word)
      node = word.each_char.inject(self) { |node, char| node.nodes[char] ||= Solver.new }
      node.word = true
    end
   
    def find(letters)
      @all = []
      @used = frequency_map(letters)
      recursive_find self, ""
      @all
    end
   
    def recursive_find(root, word)
      nodes.reject { |c, v| root.used[c] == 0 }.each { |char, node|
        root.used[char] -= 1
        node.recursive_find(root, word + char)
        root.used[char] += 1
      }
   
      root.all << word if self.word
    end
   
    def frequency_map(letters)
      letters.each_char.inject(Hash.new(0)) { |map, char| (map[char] += 1) && map }
    end
  end
end