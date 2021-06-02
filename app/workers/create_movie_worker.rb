# frozen_string_literal: true
require 'faker'

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.create(title: Faker::Movie.title)
  end
end
