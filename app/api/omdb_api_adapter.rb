# frozen_string_literal: true

require 'faker'
require 'httparty'

module OmdbApiAdapter
  def self.fetch_data(title = nil)
    title = get_movie_title if title.nil?
    response = HTTParty.get("http://www.omdbapi.com/?t=#{title}&apikey=#{omdb_key}").to_s
    JSON.parse(response)
  end

  def self.omdb_key
    ENV['OMDB_KEY']
  end

  def self.get_movie_title
    title = Faker::Movie.title
    title.gsub!(/\s/, '+')
  end
end
