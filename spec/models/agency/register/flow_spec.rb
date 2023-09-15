require 'rails_helper'

RSpec.describe Agency::Register::Flow, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:attributes) do
    {
      name: Faker::Bank.name.slice(0, 28)
    }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falhas' do
      context 'Quando nome agência for vazio' do
        it 'retorna uma falha' do
          result = described_class.call(name: '')

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          result = described_class.call(name: '')

          expect(result[:errors]).to include('O nome da agência deve ter no minimo 3 caracters')
        end
      end

      context 'Quando nome agência for maior que 40' do
        it 'retorna uma falha' do
          result = described_class.call(name: '')

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          result = described_class.call(name: Faker::Lorem.question(word_count: 60))

          expect(result[:errors]).to include('O nome de agência deve ter no máximo 40 letras')
        end
      end
    end

    describe 'sucesso' do
      context 'quando todos os dados estão corretos' do
        it 'deve retornar o objeto do Tipo Agency' do
          result = described_class.call(attributes)
          expect(result.success?).to be true
          expect(result.data[:agency]).to be_an(Agency::Record)
        end
      end
    end
  end
end
