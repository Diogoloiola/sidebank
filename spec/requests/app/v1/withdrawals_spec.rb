# frozen_string_literal: true

require 'swagger_helper'

describe 'Usuários' do
  path '/app/v1/withdrawals' do
    get 'Lista todos os saques' do
      tags 'Usuários'
      consumes 'application/json'
      security [api_key: []]

      response '200', 'Lista todos os depósitos' do
        let(:user) { create(:customer_customer) }
        let(:Authorization) { user.create_new_auth_token['Authorization'] }

        run_test!
      end
    end
  end
end
