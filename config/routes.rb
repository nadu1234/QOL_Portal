Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  
  root to: "homes#top"
  get 'about'=>"homes#about",as: "about"
  
  scope module: :public do
    resources :users, only:[:show, :edit, :update, :leave]
    resources :posts, only:[:new, :create, :update, :destroy]
    resources :comments, only:[:create, :destroy]
    resources :favorites, only:[:create, :destroy]
    resources :relationships, only:[:create, :destroy]
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
