module Codebreaker
  class Validations
    NAME_ERROR = 'You have entered invalid name'.freeze
    DIFFICULTY_ERROR = 'You have choosed invalid difficulty level'.freeze
    GUESS_ERROR = 'You have entered guess code in wrong format'.freeze
    MIN_NAME_LENGTH = 3
    MAX_NAME_LENGTH = 20
    CODE_SIZE = 4

    class << self
      def check_name_format!(input)
        raise(ValidationError.new, NAME_ERROR) unless input.match?(/^[\w ]{#{MIN_NAME_LENGTH},#{MAX_NAME_LENGTH}}$/o)
      end

      def check_diff_format!(input)
        raise(ValidationError.new, DIFFICULTY_ERROR) unless Player::DIFFICULTY_HASH.key?(input.to_sym)
      end

      def check_guess_format!(input)
        raise(ValidationError.new, GUESS_ERROR) unless input.match?(/^[1-6]{#{CODE_SIZE}}$/o)
      end
    end
  end
end
