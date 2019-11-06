class RegistrationsController < Devise::RegistrationsController

   protected

    def after_update_path_for(resource)
      if resource.is_a?(Admin)
        admin_dashboards_path
      elsif resource.is_a?(User)
        root_path
      end
    end

end
