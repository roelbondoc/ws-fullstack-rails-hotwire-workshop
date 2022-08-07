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
class Activity < ApplicationRecord
  belongs_to :account
  belongs_to :security
end
