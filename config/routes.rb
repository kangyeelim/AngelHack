Rails.application.routes.draw do
  root 'overview#index'
  resources :strategies
  resources :indicators
  resources :companies
  
end
