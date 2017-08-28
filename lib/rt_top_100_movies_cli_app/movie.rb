class RtTop100MoviesCliApp::Movie

  attr_accessor :title, :movie_url, :tomatometer_score, :audience_score, :critic_consensus, :release_date, :rating, :genre, :director, :synopsis

  @@all = []

  def initialize(title, movie_url)
    @title = title
    @movie_url = movie_url
    @@all << self
  end

  def self.create_from_collection(movies_array)
    movies_array.each do | movie |
      Movie.new(movie, movie_url)
    end
  end

  def add_details(details_hash)
    details_hash.each do | attr, value |
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end

end
