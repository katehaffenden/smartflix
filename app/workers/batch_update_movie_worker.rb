# frozen_string_literal: true
require 'sidekiq-scheduler'

class BatchUpdateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.find_each(batch_size: 100) do |movie|
      UpdateSingleMovieWorker.perform_async(movie)
    end
  end
end
