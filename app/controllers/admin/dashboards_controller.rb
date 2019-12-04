class Admin::DashboardsController < DashboardsController
  before_action :authenticate_admin!
  layout "dashboards"

  def index
    @orders = Order.all
    @products = Product.all
    @customers = Customer.all
    @users = User.all
    @cash_drawers = CashDrawer.all
    @orders = Order.all.where(is_paid: true)
  end
  
end