class OrdersController < ApplicationController
  before_action :load_orders, except: %i[accept reject]

  def index
    @orders = @orders.page(params[:page]).per(50)
  end

  def accept
    @order = Order.find(params[:id])
    @order.update(rejected_at: nil, accepted_at: Time.current)
  end

  def reject
    @order = Order.find(params[:id])
    @order.update(accepted_at: nil, rejected_at: Time.current)
  end

  def accept_all
    @orders.find_each do |order|
      OrderAcceptJob.perform_later order
    end

    render partial: 'bulk_order'
  end

  def reject_all
    @orders.find_each do |order|
      OrderRejectJob.perform_later order
    end

    render partial: 'bulk_order'
  end

  private

  def load_orders
    @orders = Order.order(posted_at: :desc).includes(:account, :security)
    @orders = @orders.where(accounts: { client_id: params[:client_id] }).joins(:account) if params[:client_id].present?
    @orders = @orders.where(account_id: params[:account_id]) if params[:account_id].present?
    @orders = @orders.where(security_id: params[:security_id]) if params[:security_id].present?
    @orders = @orders.where(order_type: params[:order_type]) if params[:order_type].present?
    @orders = @orders.where.not(rejected_at: nil) if params[:status] == 'Rejected'
    @orders = @orders.where.not(accepted_at: nil) if params[:status] == 'Accepted'
  end
end
