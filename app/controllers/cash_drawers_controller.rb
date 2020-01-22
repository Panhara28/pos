class CashDrawersController < DashboardsController
  before_action :authenticate_user!
  layout "dashboards"

  def index
    @orders_count = Order.where('is_paid=? AND checkout_date=?', true, DateTime.now.to_date).order('id desc')
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
    if @cash_drawer.status == "assign"
      puts "CASH_DRAWER_USER_ID: #{params[:cash_drawer][:user_id]}"
      puts "USER_ID: #{current_user.id }"
      puts "Compare: #{params[:cash_drawer][:user_id] === current_user.id}"
      if params[:cash_drawer][:user_id].to_i == current_user.id 
        redirect_to edit_cash_drawer_path(@cash_drawer)
        flash[:alert] = "You can`t do that!"
      else
        if @cash_drawer.update(cash_drawer_params)
          @cash_drawer.cash_drawer_details.create(user_id: current_user.id, status: "assign")
          puts "CASH_DRAWER_USER_ID: #{params[:cash_drawer][:user_id]}"
          puts "USER_ID: #{current_user.id }"
          puts "Compare: #{params[:cash_drawer][:user_id] === current_user.id}"
          redirect_to cash_drawers_path, notice: "Successful Updated"
        else
          render :edit
        end
      end
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