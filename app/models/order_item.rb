class OrderItem < ApplicationRecord
  
  belongs_to :product

  belongs_to :order

  before_save :finalize
  
  before_update :update_total

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.product_price
    end
  end

  def quantity
    self[:quantity]
  end

  def total_price
    self[:subtotal] * (1 - self[:discount] / 100)
  end

private

  def product_present
    if product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:subtotal] = quantity * self[:unit_price]
  end

  def update_total
    self[:total_price] = self[:subtotal] * (1 - self[:discount] / 100)
  end

  def self.summary_order_item(start_date, end_date, category_id)
    OrderItem.joins("INNER JOIN orders ON order_items.order_id = orders.id")
    .joins("INNER JOIN products ON order_items.product_id = products.id")
    .joins("INNER JOIN categories_products ON products.id = categories_products.product_id")
    .joins("INNER JOIN categories ON categories.id = categories_products.category_id")
    .where("orders.order_date BETWEEN ? AND ?", start_date, end_date)
    .where("categories.id = ?", category_id)
    .group(:id, :product_id)
  end

end
