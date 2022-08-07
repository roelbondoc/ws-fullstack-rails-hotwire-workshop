# == Schema Information
#
# Table name: allocations
#
#  id             :bigint           not null, primary key
#  portfolio_id   :bigint
#  asset_class_id :bigint
#  amount         :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class AllocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
