Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :objectives, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
