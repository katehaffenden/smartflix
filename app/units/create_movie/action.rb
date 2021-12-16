# frozen_string_literal: true

module CreateMovie
  class Action < ::BaseAction
    def call(title)
      movie_data = omdb_adapter.get_movie(title)
      if invalid?(movie_data)
        log_warning
      else
        movie = create_movie(movie_data)
        create_external_ratings(movie, movie_data[:ratings])
      end
    end

    attr_reader :omdb_adapter

    private

    def create_movie(movie_data)
      Movie.create!(movie_data.except(:response, :ratings))
    end

    def create_external_ratings(movie, movie_data)
      movie.external_ratings.build(movie_data)
      movie.save!
    end

    def omdb_adapter
      @omdb_adapter = Omdb::ApiAdapter.new
    end
  end
end
