# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'diaries#index'

  namespace :api do
    resources :diaries, only: %i[new create]
  end

  resources :diaries
end
