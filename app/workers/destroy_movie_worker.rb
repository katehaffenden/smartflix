# frozen_string_literal: true

require 'sidekiq-scheduler'

class DestroyMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.outdated.destroy_all
  end
end
