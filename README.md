# scrabblestuff

Simple scrabble solver gem for ruby/rails

based on the algorithm used by https://github.com/samwho/scrabble-solver

## Installation

**scrabblestuff** is hosted at rubygems.org

`gem install scrabblestuff`

## Usage

```ruby
solver = Scrabble::Solver.new
solver.load_dictionary
solver.find("astrd").sort { |x,y| x.length <=> y.length }
=> ["at", "ad", "as", "ta", "ar", "ads", "ars", "art", "tas", "tar", "tad", "sat", "sad", "rad", "rat", "ras", "rats", "rads", "sard", "drat", "star", "tads", "arts", "tars", "dart", "trad", "tsar", "darts", "drats"]
```

## Copyright

Copyright &copy; 2014 Cody Barr. See LICENSE.md for
further details.


