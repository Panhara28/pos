class Admin::CustomersController < DashboardsController
    before_action :authenticate_admin!
      layout "dashboards"
  def index
    if params[:query].present?
      @customers = Customer.search(params[:query])
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    else
      @customers = Customer.order('customer_name')
      .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    end
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to admin_customers_path, notice: "Your customer has been created."
    else
      render :new, notice: "Something went wrong."
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "Your customer been updated."
    else
      render :edit, notice: "Something went wrong."
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to admin_customers_path
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:customer_name, :email, :phone, :address, :state, :country, :photo)
    end

end
