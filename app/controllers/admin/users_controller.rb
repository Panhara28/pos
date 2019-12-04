class Admin::UsersController < DashboardsController
    layout "dashboards"
    before_action :authenticate_admin!
    before_action :admin_only?, except: [:index]
    def index
      @user = current_admin.users.build
      @users = User.all.order(id: :desc)
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def new
  
    end
  
    def create
      @user = current_admin.users.build(user_params)
      if @user.save
        respond_to do |format|
          flash.now[:notice] = "Successful Created"
          format.html { redirect_to admin_users_path }
          format.js
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please fill the field blank or user Duplicated"
          format.html { redirect_to admin_users_path }
          format.js { render template: "admin/users/user_error.js.erb" }
        end
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      no_requried_password
      @user = User.find(params[:id])
      if @user.update(user_params)
        respond_to do |format|
          flash.now[:notice] = "Successful Updated"
          format.html { redirect_to admin_users_path }
          format.js
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please fill the field blank or user Duplicated"
          format.html { redirect_to admin_users_path }
          format.js { render template: "admin/users/user_error.js.erb" }
        end
      end
    end
  
    def destroy
      @user = User.destroy(params[:id])
      respond_to do |format|
        flash.now[:error] = "Delete"
        format.html { redirect_to admin_users_url }
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
  
      def no_requried_password
        if params[:user][:password].blank?
          params[:user].delete("password")
          params[:user].delete("password_confirmation")
        end
      end
  
      def user_params
        params.required(:user).permit(:username, :email, :password, :password_confirmation, :role, :first_name, :last_name, :image)
      end

end
