require 'rails_helper'

RSpec.describe Customer::Create::RegisterCustomer, type: :user_case do # rubocop:disable Metrics/BlockLength
  let(:attributes) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      cpf: CPF.generate,
      birthdate: Faker::Date.in_date_period(year: 1990, month: 2),
      cellphone: Faker::PhoneNumber.cell_phone
    }
  end

  describe '.call' do # rubocop:disable Metrics/BlockLength
    describe 'falhas' do # rubocop:disable Metrics/BlockLength
      context 'Quando nome do usuário é vazio' do
        it 'retorna uma falha' do
          attributes[:name] = ''

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:name] = ''
          result = described_class.call(attributes).data
          expect(result[:errors].full_messages.find { |d| d[:attribute] == 'name' }.present?).to be true
        end
      end

      context 'Quando telefone do usuário é vazio' do
        it 'retorna uma falha' do
          attributes[:cellphone] = ''

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:cellphone] = ''
          result = described_class.call(attributes).data
          expect(result[:errors].full_messages.find { |d| d[:attribute] == 'cellphone' }.present?).to be true
        end
      end

      context 'Quando data de aniversário do usuário é vazio' do
        it 'retorna uma falha' do
          attributes[:birthdate] = ''

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:birthdate] = ''
          result = described_class.call(attributes).data
          expect(result[:errors].full_messages.find { |d| d[:attribute] == 'birthdate' }.present?).to be true
        end
      end

      context 'Quando email do usuário é vazio' do
        it 'retorna uma falha' do
          attributes[:email] = ''

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:email] = ''
          result = described_class.call(attributes).data
          expect(result[:errors].full_messages.find { |d| d[:attribute] == 'email' }.present?).to be true
        end
      end

      context 'Quando cpf do usuário é vazio' do
        it 'retorna uma falha' do
          attributes[:cpf] = ''

          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:invalid_attributes)
          expect(result.data.keys).to contain_exactly(:errors)
        end

        it 'expor a mensagem de erro' do
          attributes[:cpf] = ''
          result = described_class.call(attributes).data
          expect(result[:errors].full_messages.find { |d| d[:attribute] == 'cpf' }.present?).to be true
        end
      end
    end

    describe 'sucesso' do
      context 'Quando todos os dados do usuário estão corretos' do
        it 'retorna um objeto ' do
          result = described_class.call(attributes)
          expect(result.success?).to be true
          expect(result.data[:customer]).to be_an(Customer::Record)
        end

        it 'deve enviar o email para o cliente' do
          expect { described_class.call(attributes) }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end
    end
  end
end
