Rails.application.routes.draw do
 namespace :api do
   namespace :v1 do
     resources :tasks
     resources :budget_items
   end
 end
end
