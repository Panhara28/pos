class Admin::AdminsController < DashboardsController

  layout "dashboards"

  before_action :authenticate_admin!
  before_action :admin_only?

  def index
    @admins = Admin.all
    @admin = Admin.new
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new

  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_admins_path }
        format.js
      end
    else
      puts @admin.errors.full_messages
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or admin Duplicated"
        format.html { redirect_to admin_admins_path }
        format.js { render template: "admin/admins/admin_error.js.erb" }
      end
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    no_requried_password
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      flash[:notice] = "Successful Updated"
      redirect_to admin_admins_path 
    else
      flash[:alert] = "Please fill the field blank or Duplicated"
      redirect_to admin_admins_path
    end
  end

  def destroy
    @admin = Admin.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_admins_url }
      format.js
    end
  end

  private
    def admin_only?
      unless  current_admin.admin?
        unless @user == current_admin
          redirect_to admin_dashboards_path, alert: "Access Denied"
        end
      end
    end

    def no_requried_password
      if params[:admin][:password].blank?
        params[:admin].delete("password")
        params[:admin].delete("password_confirmation")
      end
    end

    def admin_params
      params.required(:admin).permit(:username, :email, :password, :password_confirmation, :role, :first_name, :last_name, :image, :is_active)
    end

end
