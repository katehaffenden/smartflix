# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie
    else
      CreateMovieWorker.perform_async(params[:title])
      render json: { body: 'Movie not found, please try back later' }.to_json, status: 404
    end
  end
end
