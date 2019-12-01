class Customer < ApplicationRecord

  OPTION_TYPES = {
    "Siliver" => 5
  }

  validates :customer_name, presence: true

  has_many :orders, dependent: :nullify


end
