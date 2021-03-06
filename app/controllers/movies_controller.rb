# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie
    else
      CreateMovieWorker.perform_async(params[:title])
      render json: { body: 'Movie not found, please try back later' }.to_json, status: :not_found
    end
  end

  def index
    @movies = Movie.page(params[:page]).per(10)
  end
end
