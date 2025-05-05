Rails.application.routes.draw do
 namespace :api do
   namespace :v1 do
     get '/convert_time', to: 'time_zone#convert'
     resources :tasks
     resources :budget_items
   end
 end
end
