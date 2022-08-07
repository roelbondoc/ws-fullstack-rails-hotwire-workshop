# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :string
#  city       :string
#  postal     :string
#  province   :string
#  country    :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
