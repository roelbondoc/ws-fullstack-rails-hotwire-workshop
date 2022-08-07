class AccountsController < ApplicationController
  def show
    @client = Client.find(params[:client_id])
    @account = Account.find(params[:id])
  end
end
