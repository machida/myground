# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root to: 'diaries#index'

  scope ':username' do
    resources :diaries
  end

  namespace :api do
    resources :games, only: %i[index]
    resources :diaries, only: %i[show]
  end
end
