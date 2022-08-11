class DashboardController < ApplicationController
  def index
  end

  def client_count
    @client_count = get_client_count
  end

  def account_count
    @account_count = get_account_count
  end

  def biggest_account
    @biggest_account = get_biggest_account
  end

  def aum
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
