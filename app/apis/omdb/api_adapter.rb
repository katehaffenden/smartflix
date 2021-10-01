# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  class ApiAdapter
    def fetch_data(title = nil)
      title = movie_title if title.nil?
      HTTParty.get("#{base_url}?t=#{title}&apikey=#{omdb_key}")
    end

    def movie_title
      title = Faker::Movie.title
      title.gsub!(/\s/, '+')
    end

    private

    def omdb_key
      ENV['OMDB_KEY']
    end

    def base_url
      ENV['BASE_URL']
    end
  end
end
