Rails.application.routes.draw do
  root to:'public/homes#top'
  get '/about' => 'public/homes#about'

  namespace :public do
    resources :customers, only:[:show, :edit, :update]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create]
    delete 'cart_items/:id' => 'cart_items#destroy_all'

    get 'orders/new' => 'orders#new'
    get 'orders/:id' => 'orders#show'
    post 'orders/confirm' => 'orders#confirm'
    post 'orders' => 'orders#create'
    get 'orders/complete' => 'orders#complete'
    get 'orders' => 'orders#index'
  end
devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registration: 'customers/registrations'
  }

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registration: 'admin/registrations'
  }

  get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    get '/orders/:id' => 'orders#show'
  end




end
