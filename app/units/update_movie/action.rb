# frozen_string_literal: true
#
module UpdateMovie
  class Action < ::BaseAction
    def call(movie)
      response = omdb_adapter.get_movie(movie.title)
      if invalid?(response)
        log_warning
      else
        movie_attributes = prepare_movie_attributes(response.parsed_response)
        update_movie(movie_attributes, movie)
      end
    end

    attr_reader :omdb_adapter

    private

    def omdb_adapter
      @omdb_adapter = Omdb::ApiAdapter.new
    end

    def update_movie(attributes, movie)
      movie.update!(attributes)
    end
  end
end
