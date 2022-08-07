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
class Security < ApplicationRecord
  include PgSearch::Model

  has_many :positions
  has_many :asset_class_securities

  multisearchable against: :symbol
  pg_search_scope :search_by_symbol, against: :symbol
end
