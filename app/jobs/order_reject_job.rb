class OrderRejectJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.slowly.update(accepted_at: nil, rejected_at: Time.current)
  end
end
