module Codebreaker
  RSpec.describe CodeChecker do
    subject(:codechecker) { described_class.new(secret, guess) }

    let(:secret) { [1, 2, 3, 4] }
    let(:guess) { [2, 1, 3, 4] }
    let!(:out_pluses) { codechecker.send(:check_pluses) }
    let!(:out_minuses) { codechecker.send(:check_minuses) }

    describe '#check_pluses' do
      context 'when guess includes right digits of secret in the same positions' do
        let(:result) { %w[+ +] }

        it 'return ["+","+"] if got exactly 2 right digits' do
          expect(out_pluses).to eq(result)
        end

        it 'replace right digits to 0 in secret_code instance variable' do
          expect(codechecker.secret_code).to eq([1, 2, nil, nil])
        end

        it 'replace right digits to 0 in user_input instance variable' do
          expect(codechecker.user_input).to eq([2, 1, nil, nil])
        end
      end

      context 'when guess does not include right digits at the same positions' do
        let(:guess) { [3, 4, 5, 6] }
        let(:result) { [] }

        it 'return empty array' do
          expect(out_pluses).to eq(result)
        end
      end
    end

    describe '#check_minuses' do
      context 'when guess include some digits of secret in different positions' do
        let(:result) { %w[- -] }

        it 'return ["-","-"] if got exactly 2 same digits' do
          expect(out_minuses).to eq(result)
        end
      end
    end

    describe '#result' do
      context 'when check codechecker work on test table of codes and guesses' do
        [
          { secret_code: '6543', guess: '5643', result: '++--' },
          { secret_code: '6543', guess: '6411', result: '+-' },
          { secret_code: '6543', guess: '6544', result: '+++' },
          { secret_code: '6543', guess: '3456', result: '----' },
          { secret_code: '6543', guess: '6666', result: '+' },
          { secret_code: '6543', guess: '2666', result: '-' },
          { secret_code: '6543', guess: '2222', result: '' },
          { secret_code: '6666', guess: '1661', result: '++' },
          { secret_code: '1234', guess: '3124', result: '+---' },
          { secret_code: '1234', guess: '1524', result: '++-' },
          { secret_code: '1234', guess: '1234', result: '++++' }
        ].each do |example|
          let(:secret) { example[:secret_code].chars.map(&:to_i) }
          let(:guess) { example[:guess].chars.map(&:to_i) }
          let(:result) { example[:result] }
          it "returns #{example[:result]} when check #{example[:secret_code]} and #{example[:guess]}" do
            expect(codechecker.result).to eq(result)
          end
        end
      end
    end
  end
end
