require 'rails_helper'

RSpec.describe Transaction::Transfer::Create::Flow, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:account_origin) { create(:account_accounts) }
  let(:account_destiny) { create(:account_accounts) }

  let(:invalid_account) { create(:account_accounts, active: false) }

  let(:attributes) do
    {
      account_origin_id: account_origin.id,
      account_destiny_id: account_destiny.id,
      value: 100
    }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falhas' do # rubocop:disable Metrics/BlockLength
      context 'Quando o valor da transferência é negativo' do
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

      context 'Quando a conta de origem está desativada' do
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
          expect(result[:errors]).to include('A conta de origem está desativada')
        end
      end

      context 'Quando a conta de destino está desativada' do
        it 'retorna uma falha' do
          attributes[:account_destiny_id] = invalid_account.id

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:account_destiny_id] = invalid_account.id

          result = described_class.call(attributes)
          expect(result[:errors]).to include('A conta de destino está desativada')
        end
      end
    end

    describe 'sucesso' do
      context 'quando todos os dados são válidos' do
        it 'deve retorna um objeto do tipo Transfer::Record' do
          result = described_class.call(attributes)

          expect(result.success?).to be true
          expect(result.data[:transaction]).to be_an(Transaction::Record)
        end

        it 'O valor deve ser descontado na conta de origem de adicionado na conta de destino' do
          previous_balance_origin = account_origin.balance
          previous_balance_destiny = account_destiny.balance

          result = described_class.call(attributes)

          expect(result.success?).to be true

          account_origin.reload
          account_destiny.reload

          expect(account_origin.balance).to eql(previous_balance_origin - attributes[:value])
          expect(account_destiny.balance).to eql(previous_balance_destiny + attributes[:value])
        end
      end
    end
  end
end
