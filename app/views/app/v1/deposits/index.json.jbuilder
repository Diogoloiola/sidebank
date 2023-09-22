json.deposits do
  json.array! @deposits, partial: 'deposit', as: :deposit
end
