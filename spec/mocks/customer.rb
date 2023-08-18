def customer
  {
    properties: {
      name: { type: :string },
      email: { type: :string, format: :email },
      cpf: { type: :string },
      birthdate: { type: :string, format: :date },
      cellphone: { type: :string }
    }
  }
end
