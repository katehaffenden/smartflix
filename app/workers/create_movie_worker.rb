# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform(title)
    response = omdb_adapter.get_movie(title)
    CreateMovie::EntryPoint.new.call(response)
  end

  private

  def omdb_adapter
    @omdb_adapter = Omdb::ApiAdapter.new
  end
end
