# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform(title)
    response = omdb_adapter.fetch_data(title)
    CreateMovie::EntryPoint.new(response)
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end
