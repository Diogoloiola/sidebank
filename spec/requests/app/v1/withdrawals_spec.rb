require 'swagger_helper'

RSpec.describe '/app/v1/withdrawals', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'Open API' do # rubocop:disable Metrics/BlockLength
    path '/app/v1/withdrawals' do
      post 'Realiza um saque de um usuário' do
        tags 'Withdrawal'
        consumes 'application/json'
        parameter name: :withdrawal, in: :body, schema: {
          type: :object,
          properties: {
            withdrawal: {
              properties: {
                origin_id: { type: :string },
                value: { type: :number }
              }
            }
          },
          required: %w[origin_id value]
        }

        response '201', 'Cria um saque' do
          produces 'application/json'
          let(:account) { create(:account_accounts, balance: 100) }

          let(:attributes) do
            {
              origin_id: account.id,
              value: 100
            }
          end

          schema type: :object, properties: { withdrawal: {
            properties: {
              origin_id: { type: :string },
              transaction_type: { type: :string },
              value: { type: :string },
              hour: { type: :string }

            }
          } }
          run_test!
        end

        response '422', 'requsição inválida' do
          produces 'application/json'
          let(:account) { create(:account_accounts) }

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
