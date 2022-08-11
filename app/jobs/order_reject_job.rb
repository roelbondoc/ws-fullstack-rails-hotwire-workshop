class OrderRejectJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.slowly.update(accepted_at: nil, rejected_at: Time.current)
    Turbo::StreamsChannel.broadcast_replace_to('bulk-order-count', target: 'bulk-order-action', partial: 'orders/bulk_order')
  end
end
