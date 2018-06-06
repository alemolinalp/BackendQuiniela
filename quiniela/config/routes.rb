Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resources :usuarios, only: [:create]
    resources :equipos, only: [:index]
    resources :partidos, only: [:index]
    resources :juegos, only: [:create]
    post'usuarios/login', to:'usuarios#login'
    get 'equipos/grupo', to: 'equipos#grupo'
    get 'equipos/equipo', to: 'equipos#equipo'
    get 'partidos/partidosEquipo', to: 'partidos#partidosEquipo'
    post 'juegos/add', to: 'juegos#add'
    get 'juegos/obtenerQuinielas', to: 'juegos#obtenerQuinielas'
  end

end
