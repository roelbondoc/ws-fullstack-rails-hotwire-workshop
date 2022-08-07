class DashboardController < ApplicationController
  def index
    @client_count = get_client_count
    @account_count = get_account_count
    @biggest_account = get_biggest_account
    @aum = get_aum
  end

  private

  def get_client_count
    Client.slowly.count
  end

  def get_account_count
    Account.slowly.count
  end

  def get_biggest_account
    Account.slowly.biggest
  end

  def get_aum
    Position.slowly.aum
  end
end
