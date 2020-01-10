class CashDrawersController < DashboardsController
  before_action :authenticate_user!
  layout "dashboards"

  def index
    @cash_drawer = current_user.cash_drawers.build
    @cash_drawers = current_user.cash_drawers.all.where(status: "assign")
  end

  def show
    @cash_drawer = CashDrawer.find(params[:id])
  end

  def new

  end

  def create
    @cash_drawer = current_user.cash_drawers.build(cash_drawer_params)
    if @cash_drawer.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to cash_drawers_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or product Duplicated"
        format.html { redirect_to admin_cash_drawers_path }
        format.js { render template: "cash_drawers/cash_drawer_error.js.erb" }
      end
    end
  end

  def edit
    @cash_drawer = CashDrawer.find(params[:id])
  end

  def update
    @cash_drawer = CashDrawer.find(params[:id])
    if @cash_drawer.update(cash_drawer_params)
      redirect_to cash_drawers_path, notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @cash_drawer = CashDrawer.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to cash_drawers_url }
      format.js
    end
  end

  private
    def cash_drawer_params
      params.required(:cash_drawer).permit!
    end

end