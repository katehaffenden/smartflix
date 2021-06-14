# frozen_string_literal: true

class CreateMovieWorker

  include Sidekiq::Worker
  include OmdbApiAdapter

  sidekiq_options queue: :movies, retry: false

  def initialize(title = nil)
    @title = title
  end

  def perform
    response = OmdbApiAdapter.fetch_data(title = @title)
    Movie.create(title: response['Title'],
                 year: response['Year'].to_i,
                 rated: response['Rated'],
                 released: response['Released'].to_datetime,
                 genre: response['Genre'],
                 plot: response['Plot'],
                 runtime: response['Runtime'],
                 language: response['Language'])
  end
end
