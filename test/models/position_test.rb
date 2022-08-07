# == Schema Information
#
# Table name: positions
#
#  id          :bigint           not null, primary key
#  account_id  :bigint
#  security_id :bigint
#  quantity    :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class PositionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
