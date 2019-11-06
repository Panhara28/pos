class Customer < ApplicationRecord


  validates :customer_name, :phone, presence: true

  has_many :orders, dependent: :nullify


end
