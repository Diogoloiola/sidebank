module App
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_customer_record!
    end
  end
end
