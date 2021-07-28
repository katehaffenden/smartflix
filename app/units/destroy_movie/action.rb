# frozen_string_literal: true

module DestroyMovie
  class Action
    def call(movie)
      movie.destroy
    end
  end
end
