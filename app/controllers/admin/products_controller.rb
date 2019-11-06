class Admin::ProductsController < DashboardsController
  before_action :authenticate_admin!
  layout "dashboards"
  def index
    @product = current_admin.products.build
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new

  end

  def create
    @product = current_admin.products.build(product_params)
    if @product.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_products_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or product Duplicated"
        format.html { redirect_to admin_products_path }
        format.js { render template: "admin/products/product_error.js.erb" }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_products_url }
      format.js
    end
  end

  private
    def admin_only?
      unless  current_admin.admin?
        unless @user == current_admin
          redirect_to admin_dashboard_path, notice: "Access Denied"
        end
      end
    end

    def product_params
      params.required(:product).permit(:product_no, :product_name, :barcode, :description, :product_price, :sale_tax, :photo, :category_id)
    end

end
