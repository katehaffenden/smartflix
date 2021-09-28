# frozen_string_literal: true

module EntryPoint
    def call(*args)
      @action.call(*args)
    end
end
