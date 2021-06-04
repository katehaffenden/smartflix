# frozen_string_literal: true

require 'faker'
require 'http'

module MovieApiAdapter

  def self.fetch_data
    response = HTTP.get("http://www.omdbapi.com/?t=#{movie_title}&apikey=#{omdb_key}")
    JSON.parse(response)
  end

  def self.omdb_key
    ENV['OMDB_KEY']
  end

  def self.movie_title
    title = Faker::Movie.title
    title.gsub!(/\s/,'+')
  end
end
