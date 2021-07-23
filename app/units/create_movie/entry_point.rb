
module CreateMovie
  class EntryPoint

    def initialize(response)
      @action = CreateMovie::Action.new.call(response)
    end

  end
end
