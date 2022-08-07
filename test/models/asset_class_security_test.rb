# == Schema Information
#
# Table name: asset_class_securities
#
#  id             :bigint           not null, primary key
#  asset_class_id :bigint
#  security_id    :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class AssetClassSecurityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
