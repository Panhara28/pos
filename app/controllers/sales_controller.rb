class SalesController < ApplicationController

  before_action :authenticate_user!

  def pos
    if params[:action] === "pos"
      session.delete("order_id#{current_user.id}")
    end
    redirect_to sales_path
  end

  def index
    @categories = Category.order(id: :asc)
    session[:order_count] = current_user.orders.where('is_paid=? AND order_date=? AND order_status=?', false, DateTime.now.to_date, 'order').count
    session[:sale_count] = current_user.orders.where('is_paid=? AND order_date=?', true, DateTime.now.to_date).count

    if params[:order_id].present?
       session["order_id#{current_user.id}"] = params[:order_id]
       @order_items = Order.unpaid_order.find(params[:order_id]).order_items
    end

    if params[:customer_id].present?
      current_order.update(customer_id: params[:customer_id])
      session["customer_id#{current_user.id}"] = params[:customer_id]
    end

    @order_items = Order.unpaid_order.find(session["order_id#{current_user.id}"]).order_items if session["order_id#{current_user.id}"].present?
    @products = Category.find(session["category_id#{current_user.id}"]).products.where(status: true).order('product_name') if session["category_id#{current_user.id}"].present?
  end

  def product
    @products = Category.find(params[:category_id]).products.where(status: true).order('product_name')
    session["category_id#{current_user.id}"] = params[:category_id] if params[:category_id].present?
  end

  def order_item
    @order = current_order
    @order.order_date = DateTime.now.to_date
    puts "Time: #{Time.zone.now.strftime("%I:%M %p")}"
    @order.order_time = Time.zone.now.strftime("%I:%M %p")
    @order.waitting_no = Order.where(order_date: DateTime.now.to_date).order('id').pluck(:waitting_no).last.to_i + 1 if @order.waitting_no.nil?
    @order.user_id = current_user.id
    @order.tax = Constant::vat
    if session["customer_id#{current_user.id}"].present?
       @order.customer_id = session["customer_id#{current_user.id}"]
    else
      @order.customer_id = 1
    end

    if !(order_item = check_exist(@order, params[:product_id].to_i)).nil?
      order_item.update(quantity: order_item.quantity + 1)
    else
      @order_item = @order.order_items.new
      @order_item.product_id = params[:product_id]
      @order_item.quantity = params[:quantity]
      @order_item.save
      puts "Show"
    end

    if @order.save
      session["order_id#{current_user.id}"] = @order.id
      @order_items = Order.find(session["order_id#{current_user.id}"]).order_items
      puts "Show Not"
    end
  end

  def check_exist(order, product_id)
    order.order_items.each do |order_item|
      if product_id == order_item.product_id
        return order_item
      end
    end
    return nil
  end

  def send_to_order
    if session["order_id#{current_user.id}"].present?
      @order = Order.find(session["order_id#{current_user.id}"])
      @order.order_status = 'order'
      if session["customer_id#{current_user.id}"].present?
        @order.customer_id = session["customer_id#{current_user.id}"]
      end
      @order.save
      session.delete("order_id#{current_user.id}")
      session.delete("customer_id#{current_user.id}")
      @order_items = @order.order_items
      session[:order_count] = current_user.orders.where('is_paid=? AND order_date=? AND order_status=?', false, DateTime.now.to_date, 'order').count
      respond_to do |format|
        flash.now[:notice] = "Save Successfully"
        format.js { render :order_item }
      end
    end
  end

  def order_item_destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    if @order_items.count == 0
      session.delete("order_id#{current_user.id}")
    end
    respond_to do |format|
      format.js { render :order_item }
    end
  end

  def send_to_printer
    @order = current_order
    if @order.update(is_paid: true)
      @order_items = @order.order_items
      session.delete("order_id#{current_user.id}")
      session.delete("customer_id#{current_user.id}")
      respond_to do |format|
        format.json {
          render json: @order_items
        }
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    redirect_to order_path(@order, state: "reciept")
  end

  def print_reciept
    @order = Order.find(params[:id])
    if @order.update(
        is_paid: true, 
        user_id: current_user.id, 
        checkout_date: Date.today, 
        checkout_time: Time.zone.now.strftime("%I:%M %p"),
        table_number: "Take Away #{SecureRandom.hex(8)}",
        real_table_number: @order.table_number,
        order_status: "completed",
        delivery_fee: @order.delivery.present? ? @order.delivery.delivery_fee : 0,
      )
      redirect_to sales_path
    end
    session.delete("order_id#{current_user.id}")
    session.delete("customer_id#{current_user.id}")
  end

end
