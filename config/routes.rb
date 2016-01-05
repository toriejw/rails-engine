Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index], defaults: { format: :json }
      resources :merchants, only: [:index], defaults: { format: :json }
      resources :items, only: [:index], defaults: { format: :json }
      resources :invoices, only: [:index], defaults: { format: :json }
      resources :invoice_items, only: [:index], defaults: { format: :json }
      resources :transactions, only: [:index], defaults: { format: :json }
    end
  end
end
