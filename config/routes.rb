Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  post 'homes/import_csv',     to: 'homes#import_csv'
  delete 'delete_all_data',    to: 'homes#delete_all_data'
  delete 'question/destroy',   to: 'homes#destroy'
end
