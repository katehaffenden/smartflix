# frozen_string_literal: true

require 'faker'
require 'httparty'

module OmdbApiAdapter
  def self.fetch_data(title = nil)
    title = get_movie_title if title.nil?
    response = HTTParty.get("http://www.omdbapi.com/?t=#{title}&apikey=#{omdb_key}")
    if response.body.include?('False') || !response.code == :ok
      Rails.logger.warn "#{title} returned an error in the response"
    else
      response.parsed_response
    end
  end

  def self.get_movie_title
    title = Faker::Movie.title
    title.gsub!(/\s/, '+')
  end

  private

  def self.omdb_key
    ENV['OMDB_KEY']
  end
end
