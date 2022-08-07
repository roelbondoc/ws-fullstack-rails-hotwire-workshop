# == Schema Information
#
# Table name: activities
#
#  id            :bigint           not null, primary key
#  account_id    :bigint
#  security_id   :bigint
#  activity_type :string
#  amount        :decimal(, )
#  posted_at     :datetime
#  effective_on  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
