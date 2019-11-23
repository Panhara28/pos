class Customer < ApplicationRecord


  validates :customer_name, presence: true

  has_many :orders, dependent: :nullify


end
