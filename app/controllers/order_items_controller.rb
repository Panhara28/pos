class OrderItemsController < DashboardsController

  before_action :authenticate_user!
  before_action :admin_only?, only: [:closed, :index]
  def index
  end

  def closed
    @orders_count = Order.where('is_paid=? AND checkout_date=?', true, DateTime.now.to_date).order('id desc')
  end

  def edit
    @orders_count = Order.where('is_paid=? AND checkout_date=?', true, DateTime.now.to_date).order('id desc')
    @order_item = OrderItem.find(params[:id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      redirect_to sales_path, notice: "Your order item been updated."
    else
      flash[:alert] = "Something went wrong."
      render :edit
    end
  end


  private
    def admin_only?
      unless  current_user.role == "admin"
        redirect_to sales_path, alert: "Access Denied"
      end
    end

    def order_item_params
       params.require(:order_item).permit!
    end

end
