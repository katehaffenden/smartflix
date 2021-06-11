# frozen_string_literal: true

require 'sidekiq-scheduler'

class CreateMovieWorker

  include Sidekiq::Worker
  include OmdbApiAdapter

  sidekiq_options queue: :movies, retry: false

  def perform
    response = OmdbApiAdapter.fetch_data
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
