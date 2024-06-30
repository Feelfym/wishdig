class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :go_to_tutorial, except: [:step1, :step2, :step3, :update_step1, :update_step2, :update_step3]

  def after_sign_in_path_for(resource)
    items_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def go_to_tutorial
    if current_user.first_sign_in?
      redirect_to step1_tutorial_path
    end
  end
end
