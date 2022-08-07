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
class Allocation < ApplicationRecord
  belongs_to :portfolio
  belongs_to :asset_class
end
