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
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
