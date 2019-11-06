class CreateAdminService
  def call
    admin = Admin.find_or_create_by!(email: Rails.application.secrets.admin_email) do |admin|
        admin.username = Rails.application.secrets.username
        admin.password = Rails.application.secrets.admin_password
        admin.password_confirmation = Rails.application.secrets.admin_password
        admin.admin!
      end
  end
end
