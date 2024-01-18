require_relative "../lib/api"

class CLI
 def run 
    system("clear")
    greet
    goodbye
    until (choice = menu) == "exit"
      case choice
      when "1"
        search_manga
      when "2"
        search_anime
      else
        puts "Invalid input. Please try again."
      end
    end
 end

 def greet
   puts "Welcome to the MyAnimeList CLI!"
 end

 def goodbye
   puts "See you next time!"
 end

 def menu 
   puts "Please select an option:"
   puts "1. Search for a manga"
   puts "2. Search for a anime"
   puts "3. Exit"
   print "Enter your selection: "
   gets.chomp.downcase
 end

 def search_manga
  puts "Please enter the name of the manga you would like to search for:"
  query = gets.chomp.strip
  puts "Searching for a Manga..."
  api = API.new(query)
  manga_data = api.parse_results_manga
  puts "Here are the results for #{query}:"
  manga_data.each do |manga|
    puts "#{manga[:index]}. Title: #{manga[:title]}, Description: #{manga[:description]}"
  end
end

def search_anime
  puts "Please enter the name of the anime you would like to search for:"
  query = gets.chomp.strip
  puts "Searching for a Anime..."
  api = API.new(query)
  results = api.parse_results_anime  
  puts "Here are the results for #{query}:"
  puts results
end
end

# Example usage:
# api = API.new("your-search-query")
# results = api.parse_results
# puts results
# https://myanimelist.net/manga.php?q=