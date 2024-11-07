Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'dashboard-stats', to: 'dashboard#stats'


      post '/signup', to: 'sessions#signup'
      post '/login', to: 'sessions#login'

      namespace :admin do
        resources :appointment
        resources :doctor


        resources :home, only: [:index, :show, :update,:destroy]
        get '/list', to: 'home#index'
        get '/details', to:'home#show'
        put '/edit', to: 'home#update'
        delete '/delete', to: 'home#destroy'

        resources :hospital


      end
      namespace :doctor do
        resources :details, only: [:create, :update, :destroy]
        resources :patient

      end
      namespace :hospital do
        resources :patient, only: [:index, :show, :update, :destroy]
        # get 'search', on: :collection
        # get 'recent', on: :collection

        resources :doctors, only: [:index, :show, :create, :update, :destroy]
      end

      namespace :patient do
        resources :form, only: [:create,:show,:update, :destroy]
        get 'details/:id', to: 'form#show'
        post'/form', to: 'form#create'
      end

      resources :appointment, only: [:create, :update, :destroy]
      get '/appointment/list', to: 'appointment#index'
      get '/appointment/:id/details', to: 'appointment#show'


      # other routes...
    end
  end
end
