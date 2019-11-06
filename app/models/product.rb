class Product < ApplicationRecord

  belongs_to :admin

  belongs_to :category

  has_many :order_items, dependent: :nullify


  default_scope { where(active: true) }

  has_attached_file :photo, style: { medium: "300x500>",thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
