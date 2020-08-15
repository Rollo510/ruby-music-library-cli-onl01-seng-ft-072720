require 'pry'

class Artist

attr_accessor :name, :songs, :artist_name

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

def self.create(name)
  name = Artist.new(name)
  name.save
  name
end

def songs
  @songs
end 

def add_song(song)
  song.artist = self unless song.artist
  @songs << song unless @songs.include? song
end

# def genres
#   Genre.all.collect do |song|
#   self.songs = song
#   end
# end  

def genres
  self.songs.collect {|song|
    song.genre}.uniq
end















end