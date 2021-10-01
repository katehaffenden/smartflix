# frozen_string_literal: true

module UpdateMovie
  class Action < ::Base
    def call(response, movie)
      if invalid?(response)
        log_warning
      else
        movie_attributes = prepare_movie_attributes(response.parsed_response)
        update_movie(movie_attributes, movie)
      end
    end

    private

    def update_movie(attributes, movie)
      movie.update!(attributes)
    end
  end
end
