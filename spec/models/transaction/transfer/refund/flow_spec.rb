require 'rails_helper'

RSpec.describe Transaction::Transfer::Refund::Flow, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:account_origin) { create(:account_accounts) }
  let(:account_destiny) { create(:account_accounts) }

  let(:attributes) do
    {
      account_origin_id: account_origin.id,
      account_destiny_id: account_destiny.id,
      value: 10
    }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falhas' do
      context 'Quando uma transferência já foi revertida' do
        it 'retorna uma falha' do
          transaction = Transaction::Transfer::Create::Flow.call(attributes).data[:transaction]

          transaction.update(reverted: true)

          result = described_class.call(transaction_id: transaction.id)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          transaction = Transaction::Transfer::Create::Flow.call(attributes).data[:transaction]

          transaction.update(reverted: true)

          result = described_class.call(transaction_id: transaction.id)

          expect(result[:errors]).to include('Essa transferência já foi revertida!!')
        end
      end
    end

    describe 'sucesso' do
      context 'Quando todos os dados forem corretos' do
        it 'deve retornar o valor da conta original' do
          previous_balance_origin = account_origin.balance
          previous_balance_destiny = account_destiny.balance

          transaction = Transaction::Transfer::Create::Flow.call(attributes).data[:transaction]

          result = described_class.call(transaction_id: transaction.id)

          expect(result.success?).to be true

          account_origin.reload
          account_destiny.reload

          expect(account_origin.balance.to_f).to eq(previous_balance_origin.to_f)
          expect(account_destiny.balance.to_f).to eq(previous_balance_destiny.to_f)
        end
      end
    end
  end
end
