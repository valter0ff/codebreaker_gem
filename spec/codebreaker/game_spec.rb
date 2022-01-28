module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }

    before do
      game.create_game_params
      game.setup_difficulty('easy')
    end

    describe '#create_game_params' do
      context 'when player start a new game' do
        it 'creates a new secret_code' do
          expect(game.secret_code.size).to eq(Validations::CODE_SIZE)
        end

        it 'creates hint_code with digits of secret_code in random order' do
          expect(game.hint_code).to match_array(game.secret_code)
        end

        it 'creates a player variable with Player class instance inside' do
          expect(game.player).to be_an_instance_of(Player)
        end
      end
    end

    describe '#setup_name' do
      context 'when input name format is valid' do
        let(:name_arg) { 'Konstantin' }

        it 'saves name if it have passed a validation' do
          expect(game.setup_name(name_arg)).to eq(game.player.name)
        end
      end

      context 'when input name format is invalid' do
        let(:name_arg) { 'Ko' }

        it 'raise error if name have not passed a validation' do
          expect { game.setup_name(name_arg) }.to raise_error(ValidationError, Validations::NAME_ERROR)
        end
      end
    end

    describe '#setup_user_guess' do
      context 'when input guess format is valid' do
        let(:guess_arg) { '1234' }
        let(:result) { '1234'.chars.map(&:to_i) }

        it 'saves user input to guess var as array if it have passed a validation' do
          game.setup_user_guess(guess_arg)
          expect(game.guess).to match_array(result)
        end
      end

      context 'when input guess format is invalid' do
        let(:guess_arg) { '4567789' }

        it 'raise error if user guess input have not passed a validation' do
          expect { game.setup_user_guess(guess_arg) }.to raise_error(ValidationError, Validations::GUESS_ERROR)
        end
      end
    end

    describe '#setup_difficulty' do
      context 'when input difficulty format is valid' do
        let(:diff_arg) { 'easy' }

        it 'calls get_difficulty method if it have passed a validation' do
          expect(game.player).to receive(:get_difficulty).with(diff_arg)
          game.setup_difficulty(diff_arg)
        end
      end

      context 'when input difficulty format is invalid' do
        let(:diff_arg) { 'easssy' }

        it 'raise error if difficulty format have not passed a validation' do
          expect { game.setup_difficulty(diff_arg) }.to raise_error(ValidationError, Validations::DIFFICULTY_ERROR)
        end
      end
    end

    describe '#hint_present?' do
      context 'when player have hints' do
        it 'returns true' do
          expect(game.hint_present?).to be true
        end
      end

      context 'when player does not have hints' do
        it 'returns false' do
          game.player.hints_used = game.player.hints
          expect(game.hint_present?).to be false
        end
      end
    end

    describe '#give_hint' do
      context 'when player have hints' do
        it 'increments player hints_used variable to 1' do
          expect { game.give_hint }.to change { game.player.hints_used }.by(1)
        end

        it 'returns last digit from hint_code variable' do
          last = game.hint_code.last
          expect(game.give_hint).to eq(last)
        end

        it 'deletes last digit from hint_code variable' do
          expect { game.give_hint }.to change { game.hint_code.size }.by(-1)
        end
      end

      context 'when player does not have hints' do
        it 'returns nil' do
          game.player.hints_used = game.player.hints
          expect(game.give_hint).to be_nil
        end
      end
    end

    describe '#no_more_attempts?' do
      context 'when player have attempts' do
        it 'returns false' do
          expect(game.no_more_attempts?).to be false
        end
      end

      context 'when player does not have attempts' do
        it 'returns true' do
          game.player.attempts_used = game.player.attempts
          expect(game.no_more_attempts?).to be true
        end
      end
    end

    describe '#check_user_guess' do
      before { game.setup_user_guess('1234') }

      context 'when player have attempts' do
        it 'increments player attempts_used variable to 1' do
          expect { game.check_user_guess }.to change { game.player.attempts_used }.by(1)
        end

        it 'calls result method from CodeChecker class' do
          codechecker = instance_double(CodeChecker)
          allow(CodeChecker).to receive(:new).and_return(codechecker)
          expect(codechecker).to receive(:result)
          game.check_user_guess
        end
      end

      context 'when player does not have attempts' do
        it 'returns nil' do
          game.player.attempts_used = game.player.attempts
          expect(game.check_user_guess).to be_nil
        end
      end
    end
  end
end
