# frozen_string_literal: true


module CreateMovie
  class Action < ::BaseAction
    def call(title)
      response = omdb_adapter.get_movie(title)
      if invalid?(response)
        log_warning
      else
        movie_attributes = prepare_movie_attributes(response.parsed_response)
        create_movie(movie_attributes)
      end
    end

    attr_reader :omdb_adapter

    private

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

    def omdb_adapter
      @omdb_adapter = Omdb::ApiAdapter.new
    end
  end
end
