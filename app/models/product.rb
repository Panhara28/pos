class Product < ApplicationRecord
  
  include ImageUploader[:image]

  belongs_to :admin

  belongs_to :category
  has_many :order_items, dependent: :nullify

  default_scope { where(active: true) }

end
