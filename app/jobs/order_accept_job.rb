class OrderAcceptJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.slowly.update(rejected_at: nil, accepted_at: Time.current)
  end
end
