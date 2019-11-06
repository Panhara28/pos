class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user_id = current_user.id
    if @customer.save
      flash[:notice] = "Your customer has been created."
      redirect_to customers_path
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.user_id = current_user.id
    if @customer.update(customer_params)
      flash[:notice] = "Your customer been updated."
      redirect_to customers_path
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def show
    @paid_orders = Customer.find(params[:id]).orders.paid_order.order('order_date')
    @unpaid_orders = Customer.find(params[:id]).orders.unpaid_order.order('order_date')
  end

  def index
    if params[:query].present?
      @customers = Customer.search(params[:query])
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    elsif params[:paid].present? && params[:order_id].present?
      order = Order.find(params[:order_id])
      order.update_attributes(is_paid: true, user_id: current_user.id, checkout_date: Date.today, checkout_time: Time.now.strftime("%H:%M:%S"))
      @customers = Customer.order('id desc')
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    elsif params[:paid_all].present? && params[:customer_id].present?
      orders = Customer.find(params[:customer_id]).orders.unpaid_order
      orders.each do |order|
        order.update_attributes(is_paid: true, user_id: current_user.id, checkout_date: Date.today, checkout_time: Time.now.strftime("%H:%M:%S"))
      end
      @customers = Customer.order('id desc')
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    else
      @customers = Customer.order('id desc')
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    end
  end

  def populate_customer_name
    @customers = Customer.select("id, customer_name")
    respond_to do |format|
      format.json {
        render json: @customers
      }
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:customer_name, :email, :phone, :address, :state, :country, :photo)
    end

end
