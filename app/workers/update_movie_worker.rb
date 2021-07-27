# frozen_string_literal: true

require 'sidekiq-scheduler'

class UpdateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.all.select(:title)
    movies.each do |movie|
      response = omdb_adapter.fetch_data(movie.title)
      UpdateMovie::EntryPoint.call(response, movie)
    end
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end
