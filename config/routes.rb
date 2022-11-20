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
    resources :customers, only: [:show, :edit, :update] #customersを　get ○○ => に直す rails routesで確認(customers/:idになっていなければよい)
  end

  namespace :admin do
    get "top" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end






end
