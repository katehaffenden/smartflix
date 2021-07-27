# frozen_string_literal: true

module UpdateMovie
  class Action < CreateMovie::Action
    def call(response, movie)
      if valid?(response)
        movie_attributes = prepare_movie_attributes(response.parsed_response)
        update_movie(movie_attributes, movie)
      else
        log_warning
      end
    end

    private

    def update_movie(attributes, movie)
      movie.update!(attributes)
    end
  end
end
