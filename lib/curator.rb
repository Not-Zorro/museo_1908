require 'csv'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = Array.new
    @artists = Array.new
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(a_id)
    @artists.find{|artist| artist.id == a_id}
  end

  def find_photograph_by_id(p_id)
    @photographs.find{|photograph| photograph.id == p_id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artist_hash = Hash.new
    @photographs.each do |photo|
      artist = find_artist_by_id(photo.artist_id)
      artist_hash[artist] ||= []
      artist_hash[artist] << photo
    end

    artists_more_than_one = []

    artist_hash.each do |artist, photos|
      artists_more_than_one << artist if photos.length > 1
    end
    artists_more_than_one
  end

  def photographs_taken_by_artist_from(country)
    matching_artists = @artists.find_all{|artist| artist.country == country}
    matching_artists.map do |artist|
      find_photographs_by_artist(artist)
    end.flatten
  end

  def load_photographs(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @photographs << Photograph.new(row)
    end
  end

  def load_artists(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @artists << Artist.new(row)
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      photo if range.include?(photo.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    age_hash = Hash.new
    find_photographs_by_artist(artist).each do |photograph|
      age_for_painting = photograph.year.to_i - artist.born.to_i
      age_hash[age_for_painting] = photograph.name
    end
    age_hash
  end
end
