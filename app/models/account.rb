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
class Account < ApplicationRecord
  include PgSearch::Model

  belongs_to :client
  belongs_to :portfolio
  has_many :positions
  has_many :securities, through: :positions

  multisearchable against: %i[name canonical_id]

  def self.biggest
    account = select('accounts.id, sum(positions.quantity * securities.value) as aum').joins(:positions).joins(:securities).group('accounts.id').order('aum desc').first
    { account: find(account.id), aum: account.aum}
  end
end
