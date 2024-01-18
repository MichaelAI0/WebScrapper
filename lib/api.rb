# api.rb
require "nokogiri"
require "open-uri"
require "pry"
require "json"

class API
  BASE_URL_ANIME = "https://myanimelist.net/anime.php?q="
  BASE_URL_MANGA = "https://myanimelist.net/manga.php?q="

  def initialize(query)
    @query = query
  end

  def search_anime
    url = "#{BASE_URL_ANIME}#{@query}"
    html = URI.open(url)
    Nokogiri::HTML(html)
  end

  def search_manga
    url = "#{BASE_URL_MANGA}+#{@query}"
    html = URI.open(url)
    Nokogiri::HTML(html)
  end

  def parse_results_anime
    results = search_anime.css("tr")
    anime_data = results.each_with_index.map do |result, index|
      title = result.at_css("strong")
      description = result.at_css("div.pt4")

      title = title ? title.text.strip : "No title available"
      description = description ? description.text.strip : "No description available"

      {index: index + 1, title: title, description: description}
    end
    anime_data
  end

  def parse_results_manga
    results = search_manga.css("tr")
    manga_data = results.each_with_index.map do |result, index|
      title_element = result.at_css("strong")
      description_element = result.at_css("div.pt4")
  
      title = title_element ? title_element.text.strip : "N/A"
      description = description_element ? description_element.text.strip : "N/A"
  
      {index: index + 1, title: title, description: description}
    end
    manga_data
  end
  
end
