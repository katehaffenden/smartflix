# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform(title)
    CreateMovie::EntryPoint.new.call(title)
  end
end
