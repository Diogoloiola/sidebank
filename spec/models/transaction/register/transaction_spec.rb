require 'rails_helper'

RSpec.describe Transaction::Register::Create, type: :user_case do
  
  let(:account1) { create(:account_accounts) }
  let(:account2) { create(:account_accounts) }

  let(:attributes) do
    {
      transaction_type: 'saque',
      value: rand(1) + 0.01,
      origin_id: account1.id,
      destiny_id: account2.id,
      description: ''
    }
  end

  describe '.call' do
    describe 'falha' do
      context 'quando o tipo de transação não for válida' do
        it 'deve retornar um erro' do
          attributes[:transaction_type] = 'qualquer coisa'
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quando id da conta origem não for fornecida' do
        it 'deve retornar um erro' do
          attributes[:origin_id] = nil
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quando id da conta destino não for fornecida' do
        it 'deve retornar um erro' do
          attributes[:destiny_id] = nil
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quando o valor for igual a zero' do
        it 'deve retornar um erro' do
          attributes[:value] = 0.0
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quando o valor for negativo' do
        it 'deve retornar um erro' do
          attributes[:value] = -1
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quando o id da conta de origem for igual da conta de destino' do
        it 'deve retornar um erro' do
          attributes[:destiny_id] = attributes[:origin_id]
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      # # ver se é msm valido isso, pois nao sei se terá acesso ao account aqui
      # context 'quando o id da conta de origem não for da conta em que iniciou a transação' do
      #   it 'deve retornar um erro' do
      #   end
      # end

      context 'quando não há dinheiro suficiente na conta' do
        it 'deve retornar um erro' do
          account1.update_column(:balance, 0.0)
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_accounts)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end
    end

    describe 'sucesso' do
      context 'quando todos os dados estão válidos' do
        it 'deve retornar um registro do Transaction::Record' do
          result = described_class.call(attributes)
          expect(result.success?).to be true
          expect(result.data[:transaction]).to be_an(Transaction::Record)
        end
      end
    end
  end
end

