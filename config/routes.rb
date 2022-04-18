Rails.application.routes.draw do
  namespace :public do
    resources :customers, only:[:show, :edit, :update]
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

  get 'admin' => 'homes#top'
  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
  end




end
