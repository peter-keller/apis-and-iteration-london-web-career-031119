require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  movie_names = []

  response_hash["results"].each do |person|
    if person["name"].downcase.split(" ").include?(character_name)
      movies = person["films"]
      for movie in movies 
        movie_names.push(getMovieTitle(movie))
      end
    end
  end
  movie_names
end

def getMovieTitle(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
  response_hash["title"]
end

def print_movies(films)
  if films.empty?
    puts "No movie"
  else
    films.each_with_index do |item, index|
      puts "#{index += 1}. #{item}"
    end
  end 
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
