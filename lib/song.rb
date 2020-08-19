require 'pry'

class Song

extend Concerns::Findable

attr_accessor :name, :artist, :genre, :file_name

@@all = []

def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist=artist if artist
  self.genre=genre if genre
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

# def self.create(song)
#   song = Song.new(song)
#   song.save
#   song
# end

def self.create(name)
  self.new(name).tap do |song|
      song.save
  end
end


def artist=(artist)
  @artist = artist
  self.artist.add_song(self)
  # artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include? self
end

def self.find_by_name(name)
  self.all.find {|song|
    song.name == name}
end

def self.find_or_create_by_name(name)
  self.find_by_name(name) || self.create(name)
end

def self.new_from_filename(file_name)
  song_name = file_name.split(" - ")[1]
  artist_name = file_name.split(" - ")[0]
  genre_name = file_name.split(" - ")[2].chomp(".mp3")
  song = self.find_or_create_by_name(song_name)
  song.artist = Artist.find_or_create_by_name(artist_name)
  song.genre = Genre.find_or_create_by_name(genre_name)
  song
end

def self.create_from_filename(file_name)
  self.new_from_filename(file_name).save
end








end