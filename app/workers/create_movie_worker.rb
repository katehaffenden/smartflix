# frozen_string_literal: true

require 'faker'
require 'http'
require 'sidekiq-scheduler'

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    response = JSON.parse(fetch_movie_data)
    Movie.create(title: response['Title'],
                 year: response['Year'].to_i,
                 rated: response['Rated'],
                 released: response['Released'].to_datetime,
                 genre: response['Genre'],
                 plot: response['Plot'],
                 runtime: response['Runtime'],
                 language: response['Language'])
  end

  private

  def fetch_movie_data
    HTTP.get("http://www.omdbapi.com/?t=#{movie_title}&apikey=#{omdb_key}")
  end

  def movie_title
    title = Faker::Movie.title
    title.gsub!(/\s/,'+')
  end

  def omdb_key
    ENV['OMDB_KEY']
  end
end
