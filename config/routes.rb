Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  get "users" => redirect("/users/sign_up") #バリデーションエラー時リロードするとエラー回避
  get "posts" => redirect("/posts/new") #バリデーションエラー時リロードするとエラー回避
  root to: "homes#top"
  get 'about'=>"homes#about",as: "about"

  scope module: :public do
    resources :users, only:[:show, :edit, :update, :leave] do
      member do
        patch :withdraw, to: 'users#withdraw', as: 'withdraw'
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts, only:[:new, :show, :edit, :create, :update, :destroy] do
      resource :favorites, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end
    resources :relationships, only:[:create, :destroy]
    resources :tags, only: [:show]
    resources :categories, only: [:show]
    get 'searches/search' => "#search"
  end

  get 'admin',to:'admin/homes#top'
  namespace :admin do
    resources :categories, only:[:index, :create, :edit, :update, :destroy]
    resources :tags, only:[:index, :create, :edit, :update, :destroy]
    resources :post_tags, only:[:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
