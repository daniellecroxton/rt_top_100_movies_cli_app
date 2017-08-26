class RtTop100MoviesCliApp::CLI
  BASE_PATH = "https://www.rottentomatoes.com/top/bestofrt"

  def call
    puts ""
    puts "********* Best of Rotten Tomatoes: TOP 100 MOVIES OF ALL TIME *********"
    puts ""
    puts "Welcome cinephile! Which of Rotten Tomatoes' Top 100 Movies would you like to see?"
    create_movies
    add_movie_details
    start
  end

  def create_movies
    movies_array = RtTop100MoviesCliApp::Scraper.scrape_top_100(BASE_PATH)
    RtTop100MoviesCliApp::Movie.create_from_collection(movies_array)
  end

  def add_movie_details
    RtTop100MoviesCliApp::Movie.all.each do | movie |
      details_hash = RtTop100MoviesCliApp::Scraper.scrape_movie(BASE_PATH + movie_url)
      movie.add_details(details_hash)
    end
  end

  def start
    puts ""
    puts "Please enter '1-25', '26-50', '51-75', '76-100', 'methodology', or 'exit':"
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
    when "1-25" || "26-50" || "51-75" || "76-100"
        list_from = input.to_i
        puts ""
        puts "********* Best of Rotten Tomatoes: #{input} TOP MOVIES OF ALL TIME *********"
        puts ""
        RtTop100MoviesCliApp::Movie.all[list_from-1, 25].each_with_index(list_from) do | movie, rank |
          puts "#{rank}. #{movie.title}"
        end
      when "methodology"
        puts "Each critic from Rotten Tomatoes' discrete list gets one vote, weighted equally. A movie must have 40 or more rated reviews to be considered. The 'Adjusted Score' comes from a weighted formula (Bayesian) that we use that accounts for variation in the number of reviews per movie."
      else
      puts "I'm not quite sure what you meant."
      start
    end
  end

  def display_movie_details(input)
    puts "This would be the movie info"
  end

end
