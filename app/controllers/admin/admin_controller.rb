class Admin::AdminController < DashboardsController

  before_action :authenticate_admin!

  layout "dashboards"

  def index
    @orders = Order.all
    @products = Product.all
    @order_items = OrderItem.all
  end

end
