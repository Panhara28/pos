class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @customer = current_user.customers.build
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new

  end

  def create
    @customer = current_user.customers.build(customer_params)
    if @customer.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to customers_path }
        format.js
      end
    else
      puts @customer.errors.full_messages
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or customer Duplicated"
        format.html { redirect_to customers_path }
        format.js { render template: "customers/customer_error.js.erb" }
      end
    end
  end

  def edit
    @orders_count = Order.where('is_paid=? AND checkout_date=?', true, DateTime.now.to_date).order('id desc')
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to customers_url }
      format.js
    end
  end

  private
    def admin_only?
      unless  current_admin_user.admin?
        unless @user == current_admin_user
          redirect_to admin_dashboard_path, notice: "Access Denied"
        end
      end
    end

    def customer_params
      params.required(:customer).permit!
    end
end
