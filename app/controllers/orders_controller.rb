class OrdersController < DashboardsController
  before_action :authenticate_user!
  def index
    if params[:query].present?
      @orders = Order.unpaid_order.search(params[:query])
    else
      @orders = Order.where('is_paid=? AND order_status=?', false, "order").order('id desc')
    end 
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
    session[:redirect] = params[:redirect]
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      
      if session[:redirect].present?
        redirect_to edit_order_path(@order, redirect: "sales", status: current_order.order_status), notice: "Your order has been updated."
      else
        redirect_to orders_path, notice: "Your order has been updated."
      end

      session.delete(:redirect)

    else 

      render :edit, notice: "Something went wrong."

    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      session.delete("order_id#{current_user.id}")
      redirect_to orders_path
    end
  end

  private
    def order_params
      params.required(:order).permit!
    end
end
