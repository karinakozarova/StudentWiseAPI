Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  root to: 'application#home'
  get '/home', to: 'application#home'

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

      resources :agreements
      resources :users, only: %i(index show)
      resources :complaints do
        put 'mark_as_in_progress', to: 'complaints#mark_as_in_progress'
        put 'mark_as_rejected', to: 'complaints#mark_as_rejected'
        put 'mark_as_resolved', to: 'complaints#mark_as_resolved'
      end
      resources :events do
        put 'mark_as_finished', to: 'events#mark_as_finished'
        put 'unmark_as_finished', to: 'events#unmark_as_finished'

        post 'participants', to: 'event_participants#create'
        delete 'participants', to: 'event_participants#destroy'

        put 'votes', to: 'event_votes#update'
        post 'votes', to: 'event_votes#create'
        delete 'votes', to: 'event_votes#destroy'
      end
      resources :expenses do
        put 'archive', to: 'expenses#archive'
        put 'unarchive', to: 'expenses#unarchive'

        post 'participants', to: 'expense_participants#create'
        delete 'participants', to: 'expense_participants#destroy'
      end
      resources :groups do
        put 'members', to: 'groups#move_member'
        delete 'members', to: 'groups#remove_member'
      end

      scope :two_fa do
        put 'enable', to: 'two_fa#enable'
        put 'disable', to: 'two_fa#disable'
        post 'challenge', to: 'two_fa#check_challenge'
      end
    end
  end
end
