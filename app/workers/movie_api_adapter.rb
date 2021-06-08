# frozen_string_literal: true

require 'faker'
require 'httparty'

module MovieApiAdapter

  def self.fetch_data
    response = HTTParty.get("http://www.omdbapi.com/?t=#{movie_title}&apikey=#{omdb_key}").to_s
    puts response
    JSON.parse(response)
  end

  private

  def self.omdb_key
    ENV['OMDB_KEY']
  end

  def self.movie_title
    title = Faker::Movie.title
    title.gsub!(/\s/,'+')
  end
end
