Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

   # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    root to: "homes#top"
    get 'homes/about' => "homes#about", as: "about"
    resources :items, only: [:index, :show]
    get 'customers/show' => "customers#show", as: "customers/my_page"
    get 'customers/edit' => "customers#edit", as: "customers/information_edit"
    patch 'customers/update' => "customers#update", as: "customers/information"
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    post 'orders/confirm'
    get 'orders/complete'
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '/' => "homes#top", as: "/"
    resources :genres, only: [:new, :index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
