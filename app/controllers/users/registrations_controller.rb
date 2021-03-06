# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end
  #
  # POST /resource
  # def create
  #   super
  # end
  #
  # GET /resource/edit
  # def edit
  #   super
  # end

  def downgrade
    @user = current_user
    if @user.role == "standard"
      flash[:alert] = "You are already a standard member."
    else
      @user.role = "standard"
      if @user.save
        Wiki.owned_by(@user).each do |wiki|
          wiki.update_attribute(:private, false)
        end
        flash[:notice] = "Account membership successfully updated."
        redirect_to root_path
      else
         flash[:alert] = "Something went wrong. Please try again later."
      end
    end
  end

  def upgrade
    @user = current_user
    if @user.role == "premium"
      flash[:alert] = "You are already a premium member."
    else
      @user.role = "premium"
      if @user.save
        flash[:notice] = "Account membership successfully updated."
        redirect_to root_path
      else
         flash[:alert] = "Something went wrong. Please try again later."
      end
    end
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  #If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
