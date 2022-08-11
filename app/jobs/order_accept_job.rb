class OrderAcceptJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.slowly.update(rejected_at: nil, accepted_at: Time.current)
    Turbo::StreamsChannel.broadcast_replace_to('bulk-order-count', target: 'bulk-order-action', partial: 'orders/bulk_order')
  end
end
