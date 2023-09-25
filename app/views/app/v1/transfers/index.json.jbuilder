json.transfers do
  json.array! @transfers, partial: 'transfer', as: :transfer
end

json.partial! 'shared/meta', pagy: @pagy
