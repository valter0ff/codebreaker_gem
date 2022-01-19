module Codebreaker
  RSpec.describe Player do
    subject(:player) { described_class.new }

    context 'when setup difficulty is easy' do
      before { player.get_difficulty('easy') }

      it 'sets hints exactly 2' do
        expect(player.hints).to eq(Player::DIFFICULTY_HASH[:easy][:hints])
      end

      it 'sets attempts exactly 15' do
        expect(player.attempts).to eq(Player::DIFFICULTY_HASH[:easy][:attempts])
      end
    end
  end
end
