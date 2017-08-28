require 'pry'

class RtTop100MoviesCliApp::Scraper

  def self.scrape_top_100(main_url)
    top_100_page = Nokogiri::HTML(open(main_url))
    movies = []
    top_100_page.css("#top_movies_main .table tr").each do | movie |
      movie_title = movie.css("a").text
      movie_url = movie.css("a").attr("href").value
      movies << {title: movie_title, movie_url: movie_url}
      binding.pry
    end
    movies
  end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))

    details_page.css('#mainColumn').each do | detail |
      movie_details[:tomatometer_score] = detail.css('.critic_score .meter-value').text,
      movie_details[:audience_score] = detail.css('.audience_score .meter-value').text,
      movie_details[:critic_consensus] = detail.css('.critic consensus').text,
      movie_details[:synopsis] = detail.css('#movieSynopsis').text
    end

    details_page.css('#mainColumn').each do | detail |
      if detail.css('.media-body .meta-label').text.include?("In Theaters:")
        movie_details[:release_date] = detail.css('.media-body .meta-value').text
      elsif detail.css('.media-body .meta-label').text.include?("Rating:")
        movie_details[:rating] = detail.css('.media-body .meta-value').text
      elsif detail.css('.media-body .meta-label').text.include?("Genre:")
        movie_details[:genre] = detail.css('.media-body .meta-value').text
      elsif detail.css('.media-body .meta-label').text.include?("Directed By:")
        movie_details[:director] = detail.css('.media-body .meta-value').text
      end
    end

    movie_details
  end

end
