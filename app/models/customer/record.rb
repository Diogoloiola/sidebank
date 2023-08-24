module Customer
  class Record < ApplicationRecord
    self.table_name = 'customer_customers'

    attr_accessor :skip_password_validation

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           authentication_keys: %i[cpf email]
    include DeviseTokenAuth::Concerns::User

    has_many :accounts, -> { where(active: true) }, class_name: 'Account::Record', foreign_key: :customer_id

    def active_for_authentication?
      super && active?
    end

    protected

    def password_required?
      return false if skip_password_validation

      super
    end
  end
end
