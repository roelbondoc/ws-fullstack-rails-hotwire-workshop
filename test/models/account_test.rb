# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  client_id    :bigint
#  portfolio_id :bigint
#  canonical_id :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
