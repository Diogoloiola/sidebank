require 'swagger_helper'

RSpec.describe 'web/v1/customers', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'Open API' do # rubocop:disable Metrics/BlockLength
    path '/web/v1/customers' do # rubocop:disable Metrics/BlockLength
      post 'cria um novo customer' do # rubocop:disable Metrics/BlockLength
        tags 'Customer'
        consumes 'application/json'
        parameter name: :customer, in: :body, schema: {
          type: :object,
          properties: {
            customer:
          },
          required: %w[name email cpf cellphone birthdate]
        }

        response '201', 'Customer criado' do
          produces 'application/json'
          let(:customer) do
            {
              name: Faker::Name.name,
              email: Faker::Internet.email,
              cpf: CPF.generate,
              birthdate: Faker::Date.in_date_period(year: 1990, month: 2),
              cellphone: Faker::PhoneNumber.cell_phone
            }
          end
          schema type: :object, properties: { customer: }
          run_test!
        end

        response '422', 'requsição inválida' do
          produces 'application/json'
          let(:customer) { create(:customer_customer) }

          schema type: :object, properties: {
            errors: {
              type: :array,
              items: {
                type: :string
              }
            }
          }
          run_test!
        end
      end
    end
  end
end
