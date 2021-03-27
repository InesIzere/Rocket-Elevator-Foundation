Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blazer::Engine, at: "blazer"

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'pages/commercial'
  get 'pages/residential'
  get 'pages/quote'# => 'application#quotes'
  #post 'create' => 'application#create'
  resources :quotes
  # authenticate :user, lamdba {|u| u.role == "admin"} do
  #   mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # end
  resources :leads
  post '/leads', to: 'leads#create'

  get 'dropbox/auth_callback' => 'dropbox#auth_callback'


  get 'corporate'  => 'pages#corporate'
  get 'test'  => 'pages#test'

  get 'residential'  => 'pages#residential'

  get 'submission' => 'quotes#submission'

  post 'submission' => 'quotes#create'

  get 'employee' => 'pages#employee'

  get 'submission' => 'pages#submission'
  
  get 'index' => 'pages#index'

  get 'users/index' => 'pages#index'
  
  get 'users/index' => 'pages#index'
  
  get 'employee' => 'pages#employee'
  
  get 'dashboard' => 'pages#dashboard'



  get 'dashboard/building' => 'dashboard#building'
  
  #Intervention


  post 'interventions' => 'interventions#create'
  get 'interventions' => 'interventions#interventions'

  get 'interventions/building' => 'interventions#building'
  get 'interventions/battery' => 'interventions#battery'
  get 'interventions/column' => 'interventions#column'
  get 'interventions/elevator' => 'interventions#elevator'
  
  resources :geolocations

  

end

