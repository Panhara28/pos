class Admin::DashboardsController < DashboardsController
  before_action :authenticate_admin!
  layout "dashboards"

  def index
    @orders = Order.all
    @products = Product.all
    @customers = Customer.all
  end
  
end