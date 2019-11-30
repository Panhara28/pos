class Delivery < ApplicationRecord
  has_many :orders
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
end