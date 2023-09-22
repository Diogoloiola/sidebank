json.deposits do
  json.array! @deposits, partial: 'deposit', as: :deposit
end

json.partial! 'shared/meta', pagy: @pagy
