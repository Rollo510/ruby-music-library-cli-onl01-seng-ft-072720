class Genre

attr_accessor :name

extend Concerns::Findable

@@all = []

def initialize(name)
  @name = name
  @songs = []
  save
end

def self.all
  @@all
end

def self.destroy_all
  @@all.clear
end

def save
  @@all << self
end

def self.create(genre)
  genre = Genre.new(genre)
  genre.save
  genre
end

def songs
  @songs
end

def artists
  self.songs.collect {|song|
    song.artist}.uniq
end












end