require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
require 'nokogiri'


class CommandLineInterface
  BASE_PATH = "http://www.rottentomatoes.com/"

  def run
    create_movies
    add_movie_details
    display_movies
  end

  def create_movies

  end

  def add_movie_details

  end

  def display_movies
    puts "Welcome! Which of Rotten Tomatoes' Top 100 Movies would you like to see?
    Please enter '1-25', '26-50', '51-75', or '76-100':"
  end

  def display_movie_details
    puts "To learn more about a specific movie, please enter the movie's rank, to return to the previous menu, type 'menu':"
  end

end
