class Invoice < ApplicationRecord
  belongs_to :order, optional: true
end
