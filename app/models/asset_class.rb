# == Schema Information
#
# Table name: asset_classes
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AssetClass < ApplicationRecord
  include PgSearch::Model

  has_many :asset_class_securities
  has_many :securities, through: :asset_class_securities

  multisearchable against: :name
end
