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
class Client < ApplicationRecord
  include PgSearch::Model

  has_many :accounts

  multisearchable against: %i[name address city postal province country phone]
  pg_search_scope :search_by_all, against: %i[name address city postal province country phone]

  def self.cities
    distinct(:city).pluck(:city).sort
  end

  def self.countries
    distinct(:country).pluck(:country).sort
  end
end
