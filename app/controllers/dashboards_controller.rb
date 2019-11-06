class DashboardsController < ActionController::Base
  layout "application"
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  # respond_to :html, :xml, :json, :js

  helper_method :current_order

  def current_order
    if !session["order_id#{current_user.id}"].nil?
      Order.find(session["order_id#{current_user.id}"])
    else
      Order.new
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name,:last_name, :gender, :birthdate, :role, :department, :photo, :pin, :is_pin_required,  :email,:password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :gender, :birthdate, :role, :department, :photo, :pin, :is_pin_required, :email,:password,:password_confirmation,:current_password])
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:login_url] || request.referer || root_path
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def store_current_location
    session['user_return_to'] = request.url
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      if admin_signed_in?
        admin_dashboards_path
      else
        root_path
      end
    else
      super
    end
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def set_locale
    locale = I18n.available_locales.include?(params[:locale].to_sym) ? params[:locale] : I18n.locale if params[:locale].present?
    I18n.locale = locale || I18n.locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge(options)
  end

end
