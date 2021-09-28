# frozen_string_literal: true

module CreateMovie
  class EntryPoint

    include ::EntryPoint

    def initialize
      @action = CreateMovie::Action.new
    end
  end
end
