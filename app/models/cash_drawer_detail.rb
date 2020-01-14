class CashDrawerDetail < ApplicationRecord
  belongs_to :cash_drawer
  belongs_to :user
end
