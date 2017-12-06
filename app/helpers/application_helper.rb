module ApplicationHelper
  def items_in_cart
    total = 0
    current_order.order_items.each do |order_item|
      total += order_item.quantity
    end
    total
  end
end
