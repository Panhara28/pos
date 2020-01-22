class CashDrawer < ApplicationRecord
  belongs_to :admin
  belongs_to :user
  has_many :cash_drawer_details
  OPTION_SELECT = [
    "assigned",
    "completed"
  ]
end