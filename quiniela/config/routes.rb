Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resources :usuarios, only: [:create]
    post'usuarios/login', to:'usuarios#login'
  end

end
