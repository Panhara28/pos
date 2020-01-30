class Order < ApplicationRecord

  OPTION_TABLE = [
    "Take Away",
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

  def cost
    order_items.collect { |oi| oi.valid? ? (oi.product.original_price * oi.quantity) : 0 }.sum
  end

  def total
    subtotal + (subtotal * self[:tax] / 100) - (subtotal * (self[:discount] / 100))
  end

  private
    def update_subtotal
      self[:subtotal] = subtotal
      self[:total] = subtotal + (subtotal * self[:tax] / 100) - (subtotal * (self[:discount] / 100))
      delivery_fe = delivery.present? ?  delivery.delivery_fee : 0
      self[:delivery_fee] = subtotal * (delivery_fe.to_d / 100)
      total_minius_tax = (total - (subtotal * self[:tax] / 100))
      profit = total_minius_tax - cost - delivery_fee
      puts "Subtotal: #{subtotal}"
      puts "Total: #{total}"
      puts "delivery fee: #{delivery_fee}"
      puts "discount: #{(subtotal * (self[:discount] / 100))}"
      puts "Tax: #{(subtotal * self[:tax] / 100)}"
      puts "Grand Total: #{total - delivery_fee}"
      self[:profit] = profit
      puts "profit: #{profit}"
    end

    def update_chash_in
      self[:total_cash_in_riel] = self[:cash] * Constant::exchange_rate + self[:cash_in_riel]
    end

end
