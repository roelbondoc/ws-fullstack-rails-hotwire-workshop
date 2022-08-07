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
class Position < ApplicationRecord
  belongs_to :account
  belongs_to :security

  def self.aum
    data = select('sum(positions.quantity * securities.value) as aum').joins(:security)
    data.map(&:aum).first
  end

  def value
    quantity * security.value
  end
end
