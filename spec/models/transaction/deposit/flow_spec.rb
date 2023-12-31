require 'rails_helper'

RSpec.describe Transaction::Deposit::Flow, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:account) { create(:account_accounts) }
  let(:invalid_account) { create(:account_accounts, active: false) }

  let(:attributes) do
    {
      account_origin_id: account.id,
      value: 100
    }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falhas' do # rubocop:disable Metrics/BlockLength
      context 'Quando o valor do depósito é negativo' do
        it 'retorna uma falha' do
          attributes[:value] = -1

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:value] = -1
          result = described_class.call(attributes)
          expect(result[:errors]).to include('O valor não poder ser negativo')
        end
      end

      context 'Quando a conta do depósito está desativada' do
        it 'retorna uma falha' do
          attributes[:account_origin_id] = invalid_account.id

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:account_origin_id] = invalid_account.id
          result = described_class.call(attributes)
          expect(result[:errors]).to include('A conta não está ativa')
        end
      end
    end

    describe 'sucesso' do
      context 'Quando todos os dados estão corretos' do
        it 'deve retorna um objeto do tipo Transfer::Record' do
          result = described_class.call(attributes)
          expect(result.success?).to be true
          expect(result.data[:transaction]).to be_an(Transaction::Record)
        end

        it 'o saldo da conta deve ter sido alterado' do
          previous_value = account.balance
          described_class.call(attributes)

          account.reload

          expect(account.balance).to eql(previous_value + attributes[:value])
        end
      end
    end
  end
end
