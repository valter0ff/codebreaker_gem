module Codebreaker
  class Game
    attr_reader :secret_code, :guess, :player, :hint_code

    def initialize
      @secret_code = []
      @guess = []
    end

    def create_game_params
      @secret_code.clear
      Validations::CODE_SIZE.times { @secret_code.push(rand(Validations::MIN_DIGIT..Validations::MAX_DIGIT)) }
      @hint_code = @secret_code.shuffle
      @player = Player.new
    end

    def setup_name(input)
      Validations.check_name_format!(input)
      player.name = input
    end

    def setup_user_guess(input)
      Validations.check_guess_format!(input)
      @guess = input.chars.map(&:to_i)
    end

    def setup_difficulty(input)
      Validations.check_diff_format!(input)
      player.get_difficulty(input)
    end

    def hint_present?
      player.hints > player.hints_used
    end

    def give_hint
      return unless hint_present?

      player.hints_used += 1
      @hint_code.pop
    end

    def no_more_attempts?
      player.attempts <= player.attempts_used
    end

    def check_user_guess
      return if no_more_attempts?

      player.attempts_used += 1
      CodeChecker.new(@secret_code.clone, @guess.clone).result
    end
  end
end
