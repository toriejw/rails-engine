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
      get "/merchants/:id/invoices", to: "merchants#merchant_invoices"

      get "/invoices/:id/transactions", to: "invoices#invoice_transactions"
      get "/invoices/:id/invoice_items", to: "invoices#invoice_invoice_items"
      get "/invoices/:id/items", to: "invoices#invoice_items"
      get "/invoices/:id/customer", to: "invoices#invoice_customer"
      get "/invoices/:id/merchant", to: "invoices#invoice_merchant"

      get "/invoice_items/:id/item", to: "invoice_items#invoice_items_item"
      get "/invoice_items/:id/invoice", to: "invoice_items#invoice_items_invoice"

      get "/items/:id/merchant", to: "items#items_merchant"
      get "/items/:id/invoice_items", to: "items#items_invoice_items"

      get "/transactions/:id/invoice", to: "transactions#transactions_invoice"

      resources :customers, only: [:index, :show], defaults: { format: :json }
      resources :merchants, only: [:index, :show], defaults: { format: :json }
      resources :items, only: [:index, :show], defaults: { format: :json }
      resources :invoices, only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions, only: [:index, :show], defaults: { format: :json }
    end
  end
end
