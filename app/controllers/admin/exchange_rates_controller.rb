class Admin::ExchangeRatesController < DashboardsController
  layout "dashboards"

  def edit
    @exchange_rate = ExchangeRate.find(1)
  end

  def update
    @exchange_rate = ExchangeRate.find (params[:id])
    if @exchange_rate.update(exchage_rate_params)
      flash
      redirect_to admin_exchange_rates_path, notice: "Your exchange rate been updated."
    else
      render :edit, notice: "Something went wrong."
    end
  end

  def index
    @exchange_rates = ExchangeRate.all.order('id desc')
  end

  private

    def exchage_rate_params
      params.require(:exchange_rate).permit(:riel_amount)
    end

end
