# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  class ApiAdapter
    def fetch_data(title = nil)
      title = movie_title if title.nil?
      response = HTTParty.get("http://www.omdbapi.com/?t=#{title}&apikey=#{omdb_key}")
      if response.body.include?('False')
        Rails.logger.warn "#{title} returned an error in the response"
      else
        response.parsed_response
      end
    end

    def movie_title
      title = Faker::Movie.title
      title.gsub!(/\s/, '+')
    end

    private

    def omdb_key
      ENV['OMDB_KEY']
    end
  end
end
