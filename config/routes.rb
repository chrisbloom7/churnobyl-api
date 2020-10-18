# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  api_version(
    module: "API::V1",
    default: true,
    defaults: { format: :json },
    header: { name: "Accept", value: "application/vnd.api+json; version=1" },
    path: { value: "v1" }
  ) do
    resources :collections do
      get 'generate', on: :member
    end
  end
end
