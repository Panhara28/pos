class Customer < ApplicationRecord

  OPTION_TYPES = {
    "Siliver" => 5
  }

  validates :customer_name, presence: true

  has_many :orders, dependent: :nullify
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
end
