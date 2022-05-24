Rails.application.routes.draw do
  root to:'public/homes#top'
  get '/about' => 'public/homes#about'

  namespace :public do
    get 'customers/confirm' => 'customers#confirm'
    get 'customers/my_page' => 'customers#show'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only:[:update]
    get 'customers/edit' => 'customers#edit'
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create]
    delete 'cart_items_destroy_all' => 'cart_items#destroy_all'

    get 'orders/new' => 'orders#new'
    get 'orders/:id' => 'orders#show'
    post 'orders/confirm' => 'orders#confirm'
    post 'orders' => 'orders#create'
    get 'orders_complete' => 'orders#complete'
    get 'orders' => 'orders#index'
  end
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registration: 'admin/registrations'
  }

  get '/admin' => 'admin/homes#top'
  namespace :admin do
    root to:'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end




end
