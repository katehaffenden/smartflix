# frozen_string_literal: true

require 'sidekiq-scheduler'

class UpdateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.all
    movies.each do |movie|
      response = omdb_adapter.get_movie(movie.title)
      UpdateMovie::EntryPoint.new.call(response, movie)
    end
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end
