class RtTop100MoviesCliApp::CLI
  BASE_PATH = "https://www.rottentomatoes.com/top/bestofrt"

  def call
    puts "********* Best of Rotten Tomatoes: TOP 100 MOVIES OF ALL TIME *********"
    create_movies
    add_movie_details
    start
  end

  def create_movies
    movies_array = Scraper.scrape_top_100(BASE_PATH)
    Student.create_from_collection(movies_array)
  end

  def add_movie_details
    Movie.all.each do | movie |
      details_hash = Scraper.scrape_movie(BASE_PATH + movie_url)
      movie.add_details(details_hash)
    end
  end

  def start
    puts ""
    puts "Welcome cinephile! Which of Rotten Tomatoes' Top 100 Movies would you like to see?"
    selection = "Please enter '1-25', '26-50', '51-75', '76-100', 'methodology', or 'exit':"
    puts selection
    input = gets.strip.downcase

    display_movies(input)

    puts ""
    puts "To learn more about a specific movie, please enter the movie's rank or to return to the previous menu, type 'menu':"
    input = gets.strip.downcase

    display_movie_details(input)

    puts ""
    puts "Would you like to see more movies? Y/N"
    input = gets.strip.downcase
      if input == "y"
        start

      else
        puts ""
        puts "The End. Thank you!"
        exit
      end
  end

  def display_movies(input)

    case input
      when "1-25"

      when "26-50"

      when "51-75"

      when "76-100"

      when "methodology"

      else
      puts "I'm not quite sure what you meant." selection
      end
    end
  end

  def display_movie_details
  end

end
