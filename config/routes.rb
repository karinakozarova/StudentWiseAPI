Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  devise_for :users, skip: :all

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        patch 'users', to: 'devise/registrations#update', as: :user_registration
        put 'users', to: 'devise/registrations#update', as: nil
        post 'users', to: 'devise/registrations#create', as: nil
        delete 'users', to: 'devise/registrations#destroy', as: nil

        post 'users/login', to: 'devise/sessions#create', as: :user_session
        delete 'users/logout', to: 'devise/sessions#destroy', as: :destroy_user_session
      end

      resources :complaints
      resources :expenses
      resources :users, only: %i(index show)
      resources :events do
        put 'mark_as_finished', to: 'events#mark_as_finished'
        put 'unmark_as_finished', to: 'events#unmark_as_finished'

        post 'participants', to: 'event_participants#create'
        delete 'participants', to: 'event_participants#destroy'

        put 'votes', to: 'event_votes#update'
        post 'votes', to: 'event_votes#create'
        delete 'votes', to: 'event_votes#destroy'
      end
    end
  end
end
