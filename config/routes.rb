Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do 
    namespace :v1 do 
      resources :airlines, param: :slug
      resources :reviews, only: [:create, :destroy]
    end 
  end 

  #this routes requests that arent for existing paths pre defined in our api back to our index path
    #reason: once we use react-router, this will allow us to handle routing to our react component without interfering 
      #with our rails routes
  get '*path', to: 'pages#index', via: :all 
end
