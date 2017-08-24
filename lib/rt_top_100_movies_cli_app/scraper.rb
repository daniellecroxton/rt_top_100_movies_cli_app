require 'pry'

class Scraper

  def self.scrape_top_100(main_url)
    top_100_page = Nokogiri::HTML(open(main_url))
    movies = []
    top_100_page.css("#top_movies_main .table").each do | movie |
      movie_name = movie.css("a.unstyled.articleLink").text
      movies << {name: movie_name}
      binding.pry
    end
    movies
  end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))

    details_page.css(''). each do | detail |
      movie_details[:tomatometer_score] = detail.css('').text,
      movie_details[:audience_score] = detail.css('').text,
      movie_details[:release_date] = detail.css('').text,
      movie_details[:rating] = detail.css('').text,
      movie_details[:genre] = detail.css('').text,
      movie_details[:director] = detail.css('').text,
      movie_details[:synopsis] = detail.css('').text,
    end
    movie_details
  end

end
