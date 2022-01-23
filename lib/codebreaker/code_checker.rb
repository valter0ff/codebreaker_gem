module Codebreaker
  class CodeChecker
    PLUS = '+'.freeze
    MINUS = '-'.freeze
    MIN_DIGIT = 1
    MAX_DIGIT = 6
    attr_reader :secret_code, :user_input

    def initialize(code, input)
      @secret_code = code
      @user_input = input
    end

    def result
      (check_pluses + check_minuses).join
    end

    private

    def check_pluses
      result = []
      user_input.each_with_index do |x, i|
        next unless secret_code[i] == x

        @secret_code[i] = 0
        @user_input[i] = 0
        result.push(PLUS)
      end
      result
    end

    def check_minuses
      result = []
      (MIN_DIGIT..MAX_DIGIT).each do |n|
        next unless user_input.include?(n)

        match = [user_input.count(n), secret_code.count(n)].min
        match.times { result.push(MINUS) }
      end
      result
    end
  end
end
