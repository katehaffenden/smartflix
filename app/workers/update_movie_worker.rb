# frozen_string_literal: true

require 'sidekiq-scheduler'

class UpdateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.all
    movies.each do |movie|
      UpdateMovie::EntryPoint.new.call(movie)
    end
  end
end
