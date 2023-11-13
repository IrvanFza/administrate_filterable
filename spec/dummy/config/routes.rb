Rails.application.routes.draw do
  namespace :admin do
    resources :users, :roles

    root to: "users#index"
  end
  root to: redirect('/admin')
end
