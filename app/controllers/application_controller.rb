class ApplicationController < ActionController::Base
  before_action :setup_application_controller_environment

  helper_method :current_user
  helper_method :is_admin?
  helper_method :logged_in?

  def current_user
    User.find_by_id(session[:current_user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    return false unless logged_in?

    current_user.is_admin?
  end

  def authenticate_user!
    redirect_to sessions_create_path unless logged_in?
  end


  private
    def setup_application_controller_environment
      if(Rails.env.development?)
        # Login as a fake user in development mode
        session[:current_user_id] = User.find_by_email("dev_user@pomonastudents.org").try(:id)
      end
    end
end
