module PosHelper

  def display_change_in_usd (order)
    number_to_currency ((order.total_cash_in_riel - order.total * Constant::exchange_rate) / Constant::exchange_rate).to_d, precision: 0
  end

  def display_change_in_riel (order)
    n = (order.total_cash_in_riel - order.total * Constant::exchange_rate) / Constant::exchange_rate
    remain = n.to_s.split('.')
    return ('0.'.to_f + remain[1].to_f) * Constant::exchange_rate
  end

end
