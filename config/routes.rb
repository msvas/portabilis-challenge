Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do

      namespace :admin do
        resources :users, only: [:destroy] do
          get 'suspend', to: 'users#suspend', as: 'suspend'
        end
      end

    end
  end
end
