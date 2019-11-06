class OrderItemsController < DashboardsController

  before_action :authenticate_user!

  def index
    @orders = User.find(current_user.id).orders.where('is_paid=? AND checkout_date=?', true, DateTime.now.to_date).order('id desc')
    session[:sale_count] = current_user.orders.where('is_paid=? AND order_date=?', true, DateTime.now.to_date).count
  end

  def edit
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

    def order_item_params
       params.require(:order_item).permit(:unit_price, :quantity, :subtotal, :discount)
    end

end
