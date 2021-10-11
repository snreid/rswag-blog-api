Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :articles, defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
