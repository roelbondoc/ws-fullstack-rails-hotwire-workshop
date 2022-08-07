# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  account_id  :bigint
#  security_id :bigint
#  order_type  :string
#  amount      :decimal(, )
#  posted_at   :datetime
#  rejected_at :datetime
#  accepted_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'sidekiq/api'

class Order < ApplicationRecord
  belongs_to :account
  belongs_to :security

  def self.orders_in_process_count
    count = 0
    queue = Sidekiq::Queue.new('default')
    queue.each do |job|
      count += 1 if job.args.first['job_class'][/(OrderAcceptJob|OrderRejectJob)/]
    end
    count
  rescue
    0
  end
end
