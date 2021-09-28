# frozen_string_literal: true

module UpdateMovie
  class EntryPoint
    include ::EntryPoint

    def initialize
      @action = UpdateMovie::Action.new
    end
  end
end
