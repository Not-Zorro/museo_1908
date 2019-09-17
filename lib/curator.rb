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
end
