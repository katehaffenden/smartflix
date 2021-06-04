# frozen_string_literal: true

require 'faker'
require 'http'
require 'sidekiq-scheduler'

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    response = fetch_movie_data
    puts response
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
