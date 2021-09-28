# frozen_string_literal: true

module CreateMovie
  class EntryPoint
    def initialize(response)
      @action = CreateMovie::Action.new
      @response = response
    end

    def call
      @action.call(@response)
    end
  end
end
