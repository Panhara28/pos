class Admin::CustomersController < DashboardsController
  before_action :authenticate_admin!
  layout "dashboards"
  def index
    @customers = Customer.all
    @customer = current_admin.customers.build
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new

  end

  def create
    @customer = current_admin.customers.build(customer_params)
    if @customer.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_customers_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or customer Duplicated"
        format.html { redirect_to admin_customers_path }
        format.js { render template: "admin/customers/customer_error.js.erb" }
      end
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "Successful Updated"
    else
      render :edit
      puts @customer.errors.full_messages
    end
  end

  def destroy
    @customer = Customer.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_customers_url }
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
