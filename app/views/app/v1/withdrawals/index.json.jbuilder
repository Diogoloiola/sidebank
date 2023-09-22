json.withdrawals do
  json.array! @withdrawals, partial: 'withdrawal', as: :withdrawal
end

json.partial! 'shared/meta', pagy: @pagy
