# frozen_string_literal: true


module CreateMovie
  class Action < ::BaseAction
    def call(title)
      movie_data = omdb_adapter.get_movie(title)
      if invalid?(movie_data)
        log_warning
      else
        create_movie(movie_data)
      end
    end

    attr_reader :omdb_adapter

    private

    def create_movie(movie_data)
      Movie.create!(title: movie_data[:title],
                   year: movie_data[:year].to_i,
                   rated: movie_data[:rated],
                   released: movie_data[:released].to_datetime,
                   genre: movie_data[:genre],
                   plot: movie_data[:plot],
                   runtime: movie_data[:runtime],
                   language: movie_data[:language])
    end

    def omdb_adapter
      @omdb_adapter = Omdb::ApiAdapter.new
    end
  end
end
