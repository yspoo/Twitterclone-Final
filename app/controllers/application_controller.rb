class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception
# For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

# call the confiured params
  before_action :configure_permitted_parameters, if: :devise_controller?

# protect the database, while allowing these fields to be updated.
  protected

# using the Block method
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:username, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:sign_in) { |user| user.permit(:username, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:account_update) { |user| user.permit(:email, :password, :password_confirmation) }
  end
# user is just a placeholder name that refers to an individual user. the name can be any name.
# if we do it this way, we have to specify every parameter(option) in our sign_up form because there are no default parameters built in.
# we don't want the user to change his username after he created the account, so we remove the :username parameter in :account_update.

=begin
There are 3 actions for Devise.
- sign_in
- sign_up
- account_update

Using the Key method (lazy way)
- Another method of dealing with devise strong parameters:
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
  where we are using the KEY method instead. By default, using this method for devise's sign_up action, the default parameters(or KEYS) (i.e :email/:password/:password_confirmation) are already permitted. Therefore, we only have to specify a single key in this case, which is :username.
=end
end
