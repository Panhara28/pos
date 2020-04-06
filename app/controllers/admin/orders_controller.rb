class Admin::OrdersController < DashboardsController
  
  before_action :authenticate_admin!
  layout "dashboards"
  def index
    @orders = Order.where(is_paid: true).order(created_at: :desc).limit(30)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new

  end

  def create
    @order = current_admin.orders.build(order_params)
    if @order.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to orders_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or order Duplicated"
        format.html { redirect_to orders_path }
        format.js { render template: "/orders/order_error.js.erb" }
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
    session[:redirect] = params[:redirect]
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to order_path(@order), notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @order = Order.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to orders_url }
      format.js
    end
  end

  private
    def order_params
      params.required(:order).permit!
    end
end
