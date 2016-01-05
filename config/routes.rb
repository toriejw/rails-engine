Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/customers/find", to: "customers#find"
      get "/invoice_items/find", to: "invoice_items#find"
      get "/invoices/find", to: "invoices#find"
      get "/items/find", to: "items#find"
      get "/merchants/find", to: "merchants#find"
      get "/transactions/find", to: "transactions#find"

      get "/customers/find_all", to: "customers#find_all"
      get "/invoice_items/find_all", to: "invoice_items#find_all"
      get "/invoices/find_all", to: "invoices#find_all"
      get "/items/find_all", to: "items#find_all"
      get "/merchants/find_all", to: "merchants#find_all"
      get "/transactions/find_all", to: "transactions#find_all"

      get "/customers/random", to: "customers#random"
      get "/invoice_items/random", to: "invoice_items#random"
      get "/invoices/random", to: "invoices#random"
      get "/items/random", to: "items#random"
      get "/merchants/random", to: "merchants#random"
      get "/transactions/random", to: "transactions#random"

      get "/merchants/:id/items", to: "merchants#merchant_items"

      resources :customers, only: [:index, :show], defaults: { format: :json }
      resources :merchants, only: [:index, :show], defaults: { format: :json }
      resources :items, only: [:index, :show], defaults: { format: :json }
      resources :invoices, only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions, only: [:index, :show], defaults: { format: :json }
    end
  end
end
