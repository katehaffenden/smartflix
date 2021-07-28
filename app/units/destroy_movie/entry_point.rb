# frozen_string_literal: true

module DestroyMovie
  class EntryPoint
    def initialize(movie)
      @action = DestroyMovie::Action.new.call(movie)
    end
  end
end
