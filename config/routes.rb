Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/customers/find", to: "customers#find"
      get "/invoice_items/find", to: "invoice_items#find"
      get "/invoices/find", to: "invoices#find"
      get "/items/find", to: "items#find"
      get "/merchants/find", to: "merchants#find"
      get "/transactions/find", to: "transactions#find"

      resources :customers, only: [:index, :show], defaults: { format: :json }
      resources :merchants, only: [:index, :show], defaults: { format: :json }
      resources :items, only: [:index, :show], defaults: { format: :json }
      resources :invoices, only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions, only: [:index, :show], defaults: { format: :json }
    end
  end
end
