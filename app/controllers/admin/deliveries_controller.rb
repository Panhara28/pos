class Admin::DeliveriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @delivery = current_admin.deliveries.build
    @deliveries = Delivery.all
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  def new

  end

  def create
    @delivery = current_admin.deliveries.build(delivery_params)
    if @delivery.save
      respond_to do |format|
        flash.now[:notice] = "Successful Created"
        format.html { redirect_to admin_deliveries_path }
        format.js
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please fill the field blank or product Duplicated"
        format.html { redirect_to admin_deliveries_path }
        format.js { render template: "admin/deliveries/delivery_error.js.erb" }
      end
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to admin_delivery_path(@delivery), notice: "Successful Updated"
    else
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to admin_deliveries_url }
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

    def delivery_params
      params.required(:delivery).permit!
    end
  
end