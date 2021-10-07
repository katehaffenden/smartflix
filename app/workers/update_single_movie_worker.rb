# frozen_string_literal: true

class UpdateSingleMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform(movie)
    UpdateMovie::EntryPoint.new.call(movie)
  end
end
