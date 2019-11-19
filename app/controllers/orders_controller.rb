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
        respond_to do |format|
          flash.now[:notice] = "Update Successfully"
          format.html { redirect_to sales_path }
          format.js
        end
      else

        redirect_to orders_path, notice: "Your order has been updated."
      end

      session.delete(:redirect)

    else 
      puts @order.errors.full_messages
      render :edit, notice: "Something went wrong."

    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      respond_to do |format|
        flash.now[:alert] = "Table #{@order.table_number} Has Been Removed!"
        format.html { redirect_to orders_path  }
        format.js
      end
      session.delete("order_id#{current_user.id}")
    end
  end

  private
    def order_params
      params.required(:order).permit!
    end
end
