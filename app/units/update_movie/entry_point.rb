# frozen_string_literal: true

module UpdateMovie
  class EntryPoint
    def initialize(response, movie)
      @action = UpdateMovie::Action.new.call(response, movie)
    end
  end
end
