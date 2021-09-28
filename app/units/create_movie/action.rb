# frozen_string_literal: true

module CreateMovie
  class Action < CreateMovie::Base
    def call(response)
      if valid?(response)
        movie_attributes = prepare_movie_attributes(response.parsed_response)
        create_movie(movie_attributes)
      else
        log_warning
      end
    end

    def create_movie(movie_attributes)
      Movie.create!(title: movie_attributes[:title],
                   year: movie_attributes[:year].to_i,
                   rated: movie_attributes[:rated],
                   released: movie_attributes[:released].to_datetime,
                   genre: movie_attributes[:genre],
                   plot: movie_attributes[:plot],
                   runtime: movie_attributes[:runtime],
                   language: movie_attributes[:language])
    end
  end
end
