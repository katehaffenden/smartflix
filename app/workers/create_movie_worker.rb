# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker
  include OmdbApiAdapter

  sidekiq_options queue: :movies, retry: false

  def perform(title)
    fetch_data(title)
    create_movie(movie_attributes)
  end

  private

  attr_reader :response

  def create_movie(movie_attributes)
    Movie.create(title: movie_attributes[:title],
                 year: movie_attributes[:year].to_i,
                 rated: movie_attributes[:rated],
                 released: movie_attributes[:released].to_datetime,
                 genre: movie_attributes[:genre],
                 plot: movie_attributes[:plot],
                 runtime: movie_attributes[:runtime],
                 language: movie_attributes[:language])
  end

  def fetch_data(title)
    @response ||= OmdbApiAdapter.fetch_data(title)
  end

  def movie_attributes
    @response.transform_keys! { |k| k.downcase.to_sym }
  end
end
