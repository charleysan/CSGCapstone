Rails.application.routes.draw do
 namespace :api do
   namespace :v1 do
     get '/convert_time', to: 'time_zone#convert'
     post '/signup', to: 'users#create'
     post '/login', to: 'sessions#create'
     get '/me', to: 'users#me'
     resources :tasks
     resources :budget_items

   end
 end
end
