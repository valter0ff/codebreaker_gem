module Codebreaker
  RSpec.describe Validations do
    let(:valid_name_length) { rand(Validations::MIN_NAME_LENGTH..Validations::MAX_NAME_LENGTH) }
    let(:to_short_name_length) { Validations::MIN_NAME_LENGTH - 1 }
    let(:to_long_name_length) { Validations::MAX_NAME_LENGTH + 1 }
    let(:validator) { described_class }

    RSpec.shared_examples 'invalid input' do
      it 'raise error' do
        expect { subject }.to raise_error(ValidationError)
      end
    end

    RSpec.shared_examples 'invalid input with message' do
      it 'raise error with exactly message' do
        expect { subject }.to raise_error.with_message(error_message)
      end
    end

    RSpec.shared_examples 'valid input' do
      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    describe 'validate name format' do
      subject { validator.check_name_format!(name) }

      context 'when name is valid' do
        let(:name) { 'a' * valid_name_length }

        it_behaves_like 'valid input'
      end

      context 'when name is to short' do
        let(:name) { 'a' * to_short_name_length }

        it_behaves_like 'invalid input'
      end

      context 'when name is to long' do
        let(:name) { 'a' * to_long_name_length }

        it_behaves_like 'invalid input'

        it_behaves_like 'invalid input with message' do
          let(:error_message) { Validations::NAME_ERROR }
        end
      end
    end

    describe 'validate difficulty format' do
      subject { validator.check_diff_format!(difficulty) }

      context 'when difficulty input is valid' do
        let(:difficulty) { 'easy' }

        it_behaves_like 'valid input'
      end

      context 'when difficulty input is wrong' do
        let(:difficulty) { 'not_so_easy' }

        it_behaves_like 'invalid input'

        it_behaves_like 'invalid input with message' do
          let(:error_message) { Validations::DIFFICULTY_ERROR }
        end
      end
    end

    describe 'validate guess format' do
      subject { validator.check_guess_format!(guess) }

      context 'when guess input is valid' do
        let(:guess) { '1356' }

        it_behaves_like 'valid input'
      end

      context 'when guess input is to long' do
        let(:guess) { '1356322' }

        it_behaves_like 'invalid input'
      end

      context 'when guess input includes digits not only from 1 to 6' do
        let(:guess) { '1117' }

        it_behaves_like 'invalid input'

        it_behaves_like 'invalid input with message' do
          let(:error_message) { Validations::GUESS_ERROR }
        end
      end
    end
  end
end
