module Codebreaker
  class Player
    attr_accessor :name, :hints_used, :attempts_used
    attr_reader :difficulty, :hints, :attempts

    DIFFICULTY_HASH = { easy: { hints: 2, attempts: 15 },
                        medium: { hints: 1, attempts: 10 },
                        hell: { hints: 1, attempts: 5 } }.freeze

    def initialize
      @hints_used = 0
      @attempts_used = 0
    end

    def get_difficulty(input)
      @hints = DIFFICULTY_HASH.dig(input.to_sym, :hints)
      @attempts = DIFFICULTY_HASH.dig(input.to_sym, :attempts)
      @difficulty = input
    end
  end
end
