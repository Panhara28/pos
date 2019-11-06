class Admin::SeatTablesController < DashboardsController
    layout "dashboards"
  def index
    @seat_tables = SeatTable.where(admin_id: params[:admin_id]).order('id desc')
    .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
  end

  def new
    @seat_table = SeatTable.new
  end

  def edit
    @seat_table = SeatTable.find(params[:id])
  end

  def show
    @seat_table = SeatTable.find(params[:id])
  end

  def create
    @seat_table = SeatTable.new(seat_table_params)
    @seat_table.admin_id = current_admin.id
    if @seat_table.save
      flash[:notice] = "Your seat table has been created."
      redirect_to admin_admin_seat_tables_path(current_admin)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
    @seat_table = SeatTable.find(params[:id])
    if @seat_table.update(seat_table_params)
      flash[:notice] = "Your seat table has been updated."
      redirect_to admin_admin_seat_tables_path(current_admin)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def destroy
    @seat_table = SeatTable.find(params[:id])
    if @seat_table.destroy
      redirect_to admin_admin_seat_tables_path(current_admin)
    end
  end

  private

    def seat_table_params
      params.require(:seat_table).permit(:table_number, :description)
    end

end
