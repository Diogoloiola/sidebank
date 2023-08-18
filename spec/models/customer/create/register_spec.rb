require 'rails_helper'

RSpec.describe Customer::Create::Register, type: :user_case do # rubocop:disable Metrics/BlockLength
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
          expect(result[:errors]).to include('O nome não pode ser vazio')
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
          expect(result[:errors]).to include('O celular não pode ser vazio')
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
          expect(result[:errors]).to include('A data de nascimento deve estar presente e o usuário deve ter mais de 18 anos') # rubocop:disable Layout/LineLength
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
          expect(result[:errors]).to include('Email é inválido')
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
          expect(result[:errors]).to include('CPF não é válido')
        end
      end

      context 'Quando tenta cadastrar um cpf duplicado' do
        it 'retorna uma falha' do
          described_class.call(attributes)

          attributes[:email] = Faker::Internet.email
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:error)
          expect(result.data.keys).to contain_exactly(:errors)
        end
      end

      context 'Quando tenta cadastrar um email duplicado' do
        it 'retorna uma falha' do
          described_class.call(attributes)

          attributes[:cpf] = CPF.generate
          result = described_class.call(attributes)

          expect(result).to be_a_failure
          expect(result.type).to be(:error)
          expect(result.data.keys).to contain_exactly(:errors)
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
