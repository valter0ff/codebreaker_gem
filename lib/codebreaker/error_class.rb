module Codebreaker
  class ValidationError < StandardError
    def initialize(msg = 'Validation error')
      super(msg)
    end
  end
end
