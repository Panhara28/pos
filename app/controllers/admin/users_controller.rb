class Admin::UsersController < DashboardsController
  before_action :authenticate_admin!
    layout "dashboards"
  def new
  end

  def index
    @users = User.order('first_name')
    .paginate(:page => params[:page], :per_page => Constant::PAGE_SIZE)
    for user in User.all
      sign_out user
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    end
  end

end
