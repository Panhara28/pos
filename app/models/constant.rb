class Constant

  def self.exchange_rate

    ExchangeRate.last.riel_amount

  end

  def self.vat
    ExchangeRate.last.vat
  end

  def self.tax
    ExchangeRate.last.tax
  end

end
