# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  class ApiAdapter
    EXCLUDED_ATTRIBUTES = %i[director actors awards poster country ratings writer type dvd boxoffice production
                             metascore imdbrating imdbvotes imdbid website].freeze
    private_constant :EXCLUDED_ATTRIBUTES

    def get_movie(title = nil)
      title = movie_title if title.nil?
      response = HTTParty.get("#{base_url}?t=#{title}&apikey=#{omdb_key}")
      transform_movie_data(response)
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

    def transform_movie_data(response)
      response = response.transform_keys! { |k| k.downcase.to_sym }
      response.except!(*EXCLUDED_ATTRIBUTES)
    end
  end
end
