# frozen_string_literal: true

module DestroyMovie
  class EntryPoint

    include ::EntryPoint

    def initialize
      @action = DestroyMovie::Action.new
    end
  end
end
