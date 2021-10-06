# frozen_string_literal: true

module UpdateMovie
  class Action < ::BaseAction
    def call(movie)
      movie_data = omdb_adapter.get_movie(movie.title)
      if invalid?(movie_data)
        log_warning
      else
        update_movie(movie_data, movie)
      end
    end

    attr_reader :omdb_adapter

    private

    def omdb_adapter
      @omdb_adapter = Omdb::ApiAdapter.new
    end

    def update_movie(movie_data, movie)
      movie.update!(movie_data.except(:response))
    end
  end
end
