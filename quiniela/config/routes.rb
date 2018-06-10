Rails.application.routes.draw do
  get 'sesiones/new'
  get 'usuarios/new'
  resources :usuarios
  resources :sesiones
  root 'sesiones#new'
  get 'logout', to: 'sesiones#destroy', as: 'logout'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resources :usuarios, only: [:create]
    resources :equipos, only: [:index]
    resources :partidos, only: [:index]
    resources :juegos, only: [:create]
    resources :resultados, only: [:create]
    post'usuarios/login', to:'usuarios#login'
    get 'equipos/grupo', to: 'equipos#grupo'
    get 'equipos/equipo', to: 'equipos#equipo'
    get 'partidos/partidosEquipo', to: 'partidos#partidosEquipo'
    post 'juegos/add', to: 'juegos#add'
    get 'juegos/obtenerQuinielas', to: 'juegos#obtenerQuinielas'
    get 'juegos/obtenerParticipantes', to: 'juegos#obtenerParticipantes'
    get 'resultados/obtenerResultados', to: 'resultados#obtenerResultados'
    post 'partidos/ingresarResultado', to: 'partidos#ingresarResultado'
    post 'partidos/reset', to: 'partidos#reset'
    post 'juegos/actualizar', to: 'juegos#actualizar'
    post 'usuarios/seguir', to: 'usuarios#seguir'
    get 'usuarios/equipo', to: 'usuarios#equipo'
    post 'usuarios/fb', to: 'usuarios#fb'
  end

end
