Rails.application.routes.draw do

    root 'sales#index'
    get "pos" => "sales#pos", as: "pos"
    get 'fast_cash/index'
    get 'sales/product' => 'sales#product', as: 'product'
    get 'sales/order_item' =>  'sales#order_item', as: 'sales_order_item'
    get 'sales/send_to_order' => 'sales#send_to_order', as: 'send_to_order'
    get 'sales/send_to_printer' => 'sales#send_to_printer', as: 'send_to_printer'
    delete '/sales/order_item_destroy/:id' => 'sales#order_item_destroy', as: 'sales_order_item_destroy'
    post 'orders/order_customer' => 'orders#order_customer', as: 'order_customer'
    post 'fast_cash/set_cash' => 'fast_cash#set_cash', as: 'set_cash'
    post 'namual_cash/usd' => 'fast_cash#set_manual_cash_usd', as: 'set_manual_cash_usd'
    post 'namual_cash/riel' => 'fast_cash#set_manual_cash_riel', as: 'set_manual_cash_riel'
    get 'customers/populate/customer_name', to: 'customers#populate_customer_name', as: 'populate_customer_name'
    post 'payment/:id' => "tables#payment", as: "payment"
    get "print_reciept/:id" => "sales#print_reciept", as: "print_reciept"
    get "print_to_kitchen/:id" => "orders#print_to_kitchen", as: "print_to_kitchen"
    get 'print_success/:id' => "orders#print_success", as: "print_success"

    resources :deliveries
    resources :order_items
    resources :orders
    resources :customers
    resources :sales, only: [:index, :show]
    resources :cash_drawers

    devise_for :users
    devise_for :admins, :controllers => { :registrations => :registrations }

    namespace :admin do
      get '/', to: 'dashboards#index', as: 'dashboards'
      resources :reports, only: [:index]
      resources :categories
      resources :products
      resources :cash_drawers
      resources :seat_tables
      resources :users
      resources :customers
      resources :reports, only: [:index]
      resources :exchange_rates
      resources :order_items
      resources :orders
      resources :admins
      resources :deliveries
    end

end
