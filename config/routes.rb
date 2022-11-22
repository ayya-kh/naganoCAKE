Rails.application.routes.draw do



  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: "public" do
    root :to => "homes#top"
    get "about" => "homes#about"

    resources :items, only: [:index, :show]
    get 'customers/my_page' => "customers#show"
    get 'customers/information/edit' => "customers#edit"
    patch 'customers/information' => "customers#update"
    get 'customers/unsubscribe' => "customers#unsubscribe"


    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    get "top" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end






end
