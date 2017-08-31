require 'pry'

class RtTop100MoviesCliApp::Scraper

  def self.scrape_top_100(main_url)
    top_100_page = Nokogiri::HTML(open(main_url))
    movies = []

    # top_100_page.css("#main_container .movie_list td").each do | movie |
    # top_100_page.xpath("html/body/table[1]/tr/td/a")
    # top_100_list = top_100_page.css("table").drop(3)

    top_100_page.css(".list.detail .info").each do | movie |
      # binding.pry

      basic_movie_info = {}
      basic_movie_info[:title] = movie.css("b a").text
      basic_movie_info[:movie_url] = movie.css("a").attr("href").value
      movies << basic_movie_info
    end
    movies
  end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))

    details_page.css('heroic-overview').each do | detail |
      binding.pry
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
