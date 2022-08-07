# == Schema Information
#
# Table name: securities
#
#  id         :bigint           not null, primary key
#  symbol     :string
#  buy_cost   :decimal(, )
#  sell_cost  :decimal(, )
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class SecurityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
