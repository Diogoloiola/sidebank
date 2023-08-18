module Customer
  module Create
    class SendEmail < Micro::Case::Strict
      attributes :customer

      def call!
        return unless customer.persisted?

        CustomerMailer.with(customer:).welcome_email.deliver_now
        Success result: { customer: }
      end
    end
  end
end
