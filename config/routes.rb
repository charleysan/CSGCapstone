Rails.application.routes.draw do
 namespace :api do
   namespace :v1 do
     resources :tasks
     resources :budget_items
      get '/convert_time', to: 'time_zone#convert'
   end
 end
end
