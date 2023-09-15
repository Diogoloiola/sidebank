require 'rails_helper'

RSpec.describe Account::Register::Flow, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:customer) { create(:customer_customer) }
  let(:agency) { create(:agencie_agencies) }

  let(:attributes) do
    { customer_id: customer.id, agency_id: agency.id, account_type: 'corrente' }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falha' do # rubocop:disable Metrics/BlockLength
      context 'quando o tipo da conta for inválida' do
        it 'deve retornar um erro' do
          attributes[:account_type] = 'errado'
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quanto o id do usuário não for fornecido' do
        it 'deve retornar um erro' do
          attributes[:customer_id] = nil
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'quanto o id da agência não for fornecido' do
        it 'deve retornar um erro' do
          attributes[:agency_id] = nil
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end
    end

    describe 'sucesso' do
      context 'quando todos os dados estão válidos' do
        it 'Deve retornar um registro do Account::Record' do
          result = described_class.call(attributes)
          expect(result.success?).to be true
          expect(result.data[:account]).to be_an(Account::Record)
        end
      end
    end
  end
end
