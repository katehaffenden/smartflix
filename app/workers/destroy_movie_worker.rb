# frozen_string_literal: true

require 'sidekiq-scheduler'

class DestroyMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.where('updated_at < ?', 2.days.ago)
    movies.each do |movie|
      DestroyMovie::EntryPoint.new(movie)
    end
  end
end
