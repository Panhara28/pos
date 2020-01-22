class Admin::CashDrawersController < DashboardsController
  before_action :authenticate_admin!

  layout "dashboards"
  def index
    @cash_drawer = current_admin.cash_drawers.build
    @cash_drawers = current_admin.cash_drawers.where(status: params[:state])
  end

  def show
    @cash_drawer = CashDrawer.find(params[:id])
  end

  def new

  end

  def create
    @cash_drawer = current_admin.cash_drawers.build(cash_drawer_params)
    if @cash_drawer.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_cash_drawers_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or product Duplicated"
        format.html { redirect_to admin_cash_drawers_path }
        format.js { render template: "admin/cash_drawers/cash_drawer_error.js.erb" }
      end
    end
  end

  def edit
    @cash_drawer = CashDrawer.find(params[:id])
  end

  def update
    @cash_drawer = CashDrawer.find(params[:id])
    if @cash_drawer.update(cash_drawer_params)
      redirect_to admin_cash_drawer_path(@cash_drawer), notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @cash_drawer = CashDrawer.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_cash_drawers_url }
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

    def cash_drawer_params
      params.required(:cash_drawer).permit!
    end

end