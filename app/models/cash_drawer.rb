class CashDrawer < ApplicationRecord
  belongs_to :admin
  belongs_to :user
  

  OPTION_STATUS = [
    "assign",
    "completed"
  ]
end