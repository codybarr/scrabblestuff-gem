require 'helper'

describe ".find" do
  it "should return correct results" do
    solver = Scrabble::Trie.new
    solver.load_dictionary
    solver.find("astrd").sort { |x,y| x.length <=> y.length }.must_equal(["at", "ad", "as", "ta", "ar", "ads", "ars", "art", "tas", "tar", "tad", "sat", "sad", "rad", "rat", "ras", "rats", "rads", "sard", "drat", "star", "tads", "arts", "tars", "dart", "trad", "tsar", "darts", "drats"])
  end
end