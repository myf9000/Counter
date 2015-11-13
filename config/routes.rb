Rails.application.routes.draw do
  get 'static_pages/about'
  resources :sentences, only: [:new, :create, :show]
  root 'sentences#new'
end
