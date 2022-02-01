module Codebreaker
  RSpec.describe Player do
    subject(:player) { described_class.new }

    let(:level) { Player::DIFFICULTY_HASH.keys.sample }

    context 'when setup difficulty is easy' do
      before { player.get_difficulty(level.to_s) }

      it 'sets hints accordingly to difficulty level' do
        expect(player.hints).to eq(Player::DIFFICULTY_HASH.dig(level, :hints))
      end

      it 'sets attempts accordingly to difficulty level' do
        expect(player.attempts).to eq(Player::DIFFICULTY_HASH.dig(level, :attempts))
      end
    end
  end
end
