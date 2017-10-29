Rails.application.routes.draw do

  devise_for :users

  root 'pages#index'


  get '/home' => 'pages#home' #override default routes.
  # this creates a prefix path

  get '/profile' => 'pages#haha'
  get '/explore' => 'pages#explore'
# The ":as" method helps us in changing the prefix for the path. By default, the prefix for the path is the same as the
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
