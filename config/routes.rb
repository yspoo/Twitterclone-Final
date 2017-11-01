Rails.application.routes.draw do

  devise_for :users#, :controllers => {:sessions => "user/sessions", :registrations => "user/registrations"}
=begin

-  :controllers => {:sessions => "user/sessions", :registrations => "user/registrations"}
will change all the actions belonging to the sessions and registrations controllers from the devise controller to belonging to the user controller. The prefix and URI pattern remains the same.

new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
    user_session POST   /users/sign_in(.:format)       devise/sessions#create
destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy

new_user_session GET    /users/sign_in(.:format)       user/sessions#new
    user_session POST   /users/sign_in(.:format)       user/sessions#create
destroy_user_session DELETE /users/sign_out(.:format)      user/sessions#destroy

=end

  root 'pages#index'


  get '/home' => 'pages#home'

  get '/user/:id' => 'pages#profile', :as => :profile
  get '/explore' => 'pages#explore'
=begin
Because we have specified our root path, we are able to use relative paths, e.g "/profile" will mean "localhost:3000/profile"

The ":as" method helps us in changing the prefix for the path. By default, if we don't use ":as", the prefix for the path is the same as the original url specified after the HTTP request.
e.g For "/profile", the prefix is profile. ["/<prefix>" gives us the default prefix]

By using ":as", we can specify the prefix to what we want and it overrides the default prefix. (Changing the prefix affects our pathing, i.e prefix_path is now different.)
=end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

=begin
devise_scope :users do
  # using login path for registration
  get '/login' => 'registrations#new', :as => :new_user_registration
  post '/signup' => 'registrations#create', :as => :user_registration
  post '/signin' => 'sessions#create', :as => :user_session
end
=end
