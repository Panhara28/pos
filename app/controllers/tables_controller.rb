class TablesController < ApplicationController
  def index
  end

  def show
    @table = SeatTable.find(params[:id])
    @orders = @table.orders.where(is_paid: false)
  end

  def payment
    @table = SeatTable.find(params[:id])
    @orders = @table.orders
    @orders.each do |order|
      order.update(is_paid: true)
      Invoice.create(order_id: order.seat_table_id)
    end
    redirect_to sales_path
  end
  

end
