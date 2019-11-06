class Admin::CategoriesController < DashboardsController
    layout "dashboards"
    before_action :authenticate_admin!
  def index
    @category = current_admin.categories.build
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new

  end

  def create
    @category = current_admin.categories.build(category_params)
    if @category.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_categories_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or category Duplicated"
        format.html { redirect_to admin_categorys_path }
        format.js { render template: "admin/categories/category_error.js.erb" }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find_by_slug(params[:id])
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_categories_url }
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

    def category_params
      params.required(:category).permit!
    end

end
