# == Schema Information
#
# Table name: portfolios
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Portfolio < ApplicationRecord
  include PgSearch::Model

  has_many :allocations
  has_many :accounts
  has_many :clients, through: :accounts

  multisearchable against: :name
  pg_search_scope :search_by_name, against: :name
end
