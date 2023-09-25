json.extract! me, :id, :name, :cpf, :email, :birthdate, :cellphone

json.accounts me.accounts, :id, :code, :account_type, :opening_date