class OrdersController < DashboardsController
  before_action :authenticate_user!
  def index
    # if params[:query].present?
    #   @orders = Order.unpaid_order.search(params[:query])
    # else
    #   @orders = Order.where('is_paid=? AND order_status=?', false, "order").order('id desc')
    # end 
    if params[:state] == "ordered"
      @orders = Order.where('is_paid=? AND order_status=?', false, "order").order('created_at desc')
    else
      @orders = Order.where('is_paid=? AND order_status=?', true, "completed").order('created_at desc')
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = Order.unpaid_order.find(session["order_id#{current_user.id}"]).order_items if session["order_id#{current_user.id}"].present?
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
    session[:redirect] = params[:redirect]
  end

  def edit_setting 
    @order_setting = Order.find(params[:id])
    session[:redirect] = params[:redirect]
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)      
      if session[:redirect].present?
        flash[:notice] = "Update Successfully"
        redirect_to order_path(@order)
      else
        redirect_to orders_path, notice: "Your order has been updated."
      end
      session.delete(:redirect)
    else 
      puts @order.errors.full_messages
      render :edit, notice: "Something went wrong."
    end
  end

  def update_to_setting
    @order = Order.find(params[:id])

    if @order.update(order_params)      
      if session[:redirect].present?
        flash[:notice] = "Update Successfully"
        redirect_to sales_path
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

  
  def print_to_kitchen
    @order = Order.find(params[:id])
  end

  def print_success
    redirect_to sales_path
    flash[:notice] = "Print To Kitchen Successfully"
  end

  private
    def order_params
      params.required(:order).permit!
    end
end
