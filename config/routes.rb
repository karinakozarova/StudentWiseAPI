Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  devise_for :users, skip: :all

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'users/login', to: 'users/sessions#create', as: :user_session
        delete 'users/logout', to: 'users/sessions#destroy', as: :destroy_user_session

        patch 'users', to: 'users/registrations#update', as: :user_registration
        put 'users', to: 'users/registrations#update', as: nil
        post 'users', to: 'users/registrations#create', as: nil
        delete 'users', to: 'users/registrations#destroy', as: nil
      end
    end
  end
end
