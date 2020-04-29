Rails.application.routes.draw do
  scope module: :api do
    namespace :v1 do
      resources :npcs do
        get 'random', on: :collection
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
