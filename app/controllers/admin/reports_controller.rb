class Admin::ReportsController < DashboardsController
  before_action :authenticate_admin!
    layout "dashboards"
  def index
    if params[:commit].present?
      if params[:report][:dailly_sale_date_from].present? && params[:report][:dailly_sale_date_to].present?
        @dailly_sales = Order.paid_order.where("checkout_date BETWEEN ? AND ?", params[:report][:dailly_sale_date_from],  params[:report][:dailly_sale_date_to]).order('id desc')
        session[:dailly_sale_date_from] = params[:report][:dailly_sale_date_from]
        session[:dailly_sale_date_to] = params[:report][:dailly_sale_date_to]
      elsif params[:report][:dailly_sale_by_seller_from].present? && params[:report][:dailly_sale_by_seller_to].present?
        @dailly_sale_by_sellers = Order.paid_order.where("checkout_date BETWEEN ? AND ? AND user_id= ?", params[:report][:dailly_sale_by_seller_from], params[:report][:dailly_sale_by_seller_to], params[:report][:user]).order('id desc')
        session[:dailly_sale_by_seller_from] = params[:report][:dailly_sale_by_seller_from]
        session[:dailly_sale_by_seller_to] = params[:report][:dailly_sale_by_seller_to]
        session[:user_id] = params[:report][:user]
      elsif params[:report][:cash_drawer_date_from].present? && params[:report][:cash_drawer_date_to].present?
        @cash_drawers = CashDrawer.where("cash_drawer_date BETWEEN ? AND ?", params[:report][:cash_drawer_date_from], params[:report][:cash_drawer_date_to]).order('id desc')
        session[:cash_drawer_date_from] = params[:report][:cash_drawer_date_from]
        session[:cash_drawer_date_to] = params[:report][:cash_drawer_date_to]
      elsif params[:report][:stock_requested_by_seller_from].present? && params[:report][:stock_requested_by_seller_to].present?
        @stock_requested_by_sellers = StockRequest.where("request_date BETWEEN ? AND ? AND user_id=?", params[:report][:stock_requested_by_seller_from], params[:report][:stock_requested_by_seller_to],  params[:report][:user]).order('id desc')
        session[:stock_requested_by_seller_from] = params[:report][:stock_requested_by_seller_from]
        session[:stock_requested_by_seller_to] = params[:report][:stock_requested_by_seller_to]
        session[:user_id] = params[:report][:user]
      elsif params[:report][:expenses_from].present? && params[:report][:expenses_to].present?
        @expenses = Expense.where("expense_date BETWEEN ? AND ?", params[:report][:expenses_from], params[:report][:expenses_to]).order('id desc')
        session[:expenses_from] = params[:report][:expenses_from]
        session[:expenses_to] = params[:report][:expenses_to]
      elsif params[:report][:dailly_sale_by_category_from].present? && params[:report][:dailly_sale_by_category_to].present?
        @dailly_sale_by_categories = OrderItem.summary_order_item(params[:report][:dailly_sale_by_category_from], params[:report][:dailly_sale_by_category_to], params[:report][:category])
        session[:dailly_sale_by_category_from] = params[:report][:dailly_sale_by_category_from]
        session[:dailly_sale_by_category_to] = params[:report][:dailly_sale_by_category_to]
        session[:category_id] = params[:report][:category]
      end
    else
      session.delete(:dailly_sale_date_from)
      session.delete(:dailly_sale_date_to)
      session.delete(:dailly_sale_by_seller_from)
      session.delete(:dailly_sale_by_seller_to)
      session.delete(:user_id)
      session.delete(:cash_drawer_date_from)
      session.delete(:cash_drawer_date_to)
      session.delete(:stock_requested_by_seller_from)
      session.delete(:stock_requested_by_seller_to)
      session.delete(:expenses_from)
      session.delete(:expenses_to)
      session.delete(:dailly_sale_by_category_from)
      session.delete(:dailly_sale_by_category_to)
      session.delete(:category_id)
    end
  end

end
