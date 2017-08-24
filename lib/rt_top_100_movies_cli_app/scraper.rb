require 'pry'

class Scraper

  def self.scrape_top_100(main_url)
    top_100_page = Nokogiri::HTML(open(main_url))
    movies = []
    top_100_page.css("#top_movies_main .table").each do | movie |
      movie_title = movie.css("a.unstyled.articleLink").text
      movie_url = movie.css("a").attr("href").value
      movies << {title: movie_title, movie_url: movie_url}
      binding.pry
    end
    movies
  end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))

    details_page.css('#mainColumn'). each do | detail |
      movie_details[:tomatometer_score] = detail.css('.critic_score .meter-value').text,
      # .critic_score .meter-value
      movie_details[:audience_score] = detail.css('.audience_score .meter-value').text,
      #  .audience_score .meter-value
      movie_details[:critic_consensus] = detail.css('.critic consensus').text,
      # .critic consensus
      movie_details[:synopsis] = detail.css('#movieSynopsis').text
      # #movieSynopsis
    end

    details_page.css('#mainColumn'). each do | detail |
      if detail.css('.media-body .meta-label').text.include?("In Theaters:")
        movie_details[:release_date] = detail.css('.media-body .meta-value').text,
      # .media-body if .meta-value = "In Theaters:"
      if detail.css('.media-body .meta-label').text.include?("Rating:")
        movie_details[:rating] = detail.css('.media-body .meta-value').text,
      # .media-body .meta-value if .meta-label = "Rating:"
      if detail.css('.media-body .meta-label').text.include?("Genre:")
        movie_details[:genre] = detail.css('.media-body .meta-value').text,
      # .media-body .meta-value if .meta-label = "Genre:"
      if detail.css('.media-body .meta-label').text.include?("Directed By:")
        movie_details[:director] = detail.css('.media-body .meta-value').text
      # .media-body .meta-value if .meta-label = "Directed By:"
      end
    end

    movie_details
  end

end
