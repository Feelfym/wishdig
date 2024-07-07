class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :go_to_tutorial, only: [:index, :show]
  before_action :basic_auth

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
    if user_signed_in? && current_user.first_sign_in?
      redirect_to step1_tutorial_path
    end
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end

end
