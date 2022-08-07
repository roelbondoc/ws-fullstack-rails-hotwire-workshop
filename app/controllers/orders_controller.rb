class OrdersController < ApplicationController
  before_action :load_orders, except: %i[accept reject]

  def index
  end

  def accept
    @order = Order.find(params[:id])
    @order.slowly.update(rejected_at: nil, accepted_at: Time.current)
    redirect_to orders_path
  end

  def reject
    @order = Order.find(params[:id])
    @order.slowly.update(accepted_at: nil, rejected_at: Time.current)
    redirect_to orders_path
  end

  def accept_all
    @orders.find_each do |order|
      OrderAcceptJob.perform_later order
    end
    redirect_to orders_path
  end

  def reject_all
    @orders.find_each do |order|
      OrderRejectJob.perform_later order
    end
    redirect_to orders_path
  end

  private

  def load_orders
    @orders = Order.order(posted_at: :desc).includes(:account, :security).page(params[:page]).per(50)
    @orders = @orders.where(accounts: { client_id: params[:client_id] }).joins(:account) if params[:client_id].present?
    @orders = @orders.where(account_id: params[:account_id]) if params[:account_id].present?
    @orders = @orders.where(security_id: params[:security_id]) if params[:security_id].present?
    @orders = @orders.where(order_type: params[:order_type]) if params[:order_type].present?
    @orders = @orders.where.not(rejected_at: nil) if params[:status] == 'Rejected'
    @orders = @orders.where.not(accepted_at: nil) if params[:status] == 'Accepted'
  end
end
