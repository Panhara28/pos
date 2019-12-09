class Admin::ExchangeRatesController < DashboardsController
  before_action :authenticate_admin!
  layout 'dashboards'
  def index
    @settings = ExchangeRate.order(id: :desc)
  end

  def show
    @setting = ExchangeRate.find(params[:id])
  end

  def edit
    @setting = ExchangeRate.find(params[:id])
  end

  def update
    @setting = ExchangeRate.find(params[:id])
    if @setting.update(setting_params)
      respond_to do |format|
        flash.now[:notice] = "Successful Updated"
        format.html { redirect_to edit_admin_exchange_rate_path(@setting) }
        format.js
      end
      

    else
      render :edit
    end
  end

  def destroy
    @setting = ExchangeRate.destroy(params[:id])
    respond_to do |format|
      flash.now[:error] = "Delete"
      format.html { redirect_to settings_url }
      format.js
    end
  end

  private
    def setting_params
      params.required(:exchange_rate).permit(:usd_amount, :riel_amount, :vat)
    end
end