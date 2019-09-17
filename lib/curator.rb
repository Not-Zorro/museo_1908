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
end
