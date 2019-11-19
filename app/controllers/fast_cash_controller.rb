class FastCashController < ApplicationController

  def index

  end

  def set_manual_cash_usd
    current_order.update(cash: params[:usd], cash_in_riel: 0)
    redirect_to sales_path
  end

  def set_manual_cash_riel
    current_order.update(cash_in_riel: params[:riel], cash: 0)
    redirect_to sales_path
  end

end
