Rails.application.routes.draw do

  get 'static_pages/about'
  resources :sentences, only: [:new, :create, :show]
  root 'sentences#new'
  get '/download_pdf/:id(.:format)' => 'sentences#show', :method => :get, :as=>:show

  resources :contacts, only: [:new, :create]
end
