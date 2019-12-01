class Order < ApplicationRecord

  OPTION_TABLE = [
    "Take Away #{SecureRandom.hex(8)}",
    "Delivery #{SecureRandom.hex(8)}",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "9",
    "10"
  ]

  validates :table_number, uniqueness: true

  belongs_to :user

  belongs_to :customer

  belongs_to :seat_table, optional: true

  has_many :invoices

  has_many :order_items, dependent: :destroy

  belongs_to :delivery, optional: true

  scope :unpaid_order, -> { where(is_paid: false) }

  scope :paid_order, -> { where(is_paid: true) }


  before_save :update_subtotal

  before_update :update_chash_in

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) * (1 - oi.discount / 100) : 0 }.sum
  end

  def finalize_profit
    order_items.collect { |oi| oi.valid? ? total - (oi.quantity * oi.original_price) * (1 - oi.discount / 100) : 0 }.sum
  end

  def total

    subtotal + self[:tax] + self[:shipping] - (subtotal * (self[:discount] / 100))
 
  end

  private

    def update_subtotal
      self[:subtotal] = subtotal
      self[:total] = subtotal + self[:tax]+ self[:shipping] - (subtotal * (self[:discount] / 100))
      self[:profit] = finalize_profit
    end

    def update_chash_in
      self[:total_cash_in_riel] = self[:cash] * Constant::exchange_rate + self[:cash_in_riel]
    end

end
