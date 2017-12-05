FactoryBot.define do
  factory :order do
    status "MyString"
    total_price "9.99"
    tax "9.99"
    shipping "9.99"
    subtotal "9.99"
    order_number 1
    account_id 1
  end
end
