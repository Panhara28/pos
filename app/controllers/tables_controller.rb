class TablesController < ApplicationController
  def index
  end

  def show
    @table = SeatTable.find(params[:id])
    @orders = @table.orders.where(is_paid: false)
    @playgrounds = @table.orders.where(is_paid: true)
  end

  def payment
    @table = SeatTable.find(params[:id])
    @orders = @table.orders
    @orders.each do |order|
      order.update(is_paid: true)
      Invoice.create(order_id: order.id)
    end
    redirect_to sales_path
  end


end
