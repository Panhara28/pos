class TablesController < ApplicationController
  def index

  end

  def show
    @table = SeatTable.find(params[:id])
    @orders = @table.orders.where(is_paid: false)
  end

end