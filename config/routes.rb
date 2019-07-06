Rails.application.routes.draw do
  get 'screener/strategies' => 'screener#strategies'
  get 'screener/strategies/:strategy_id/companies' => 'screener#companies'
  get 'screener/strategies/:strategy_id/companies/:company_id/indicators' => 'screener#indicators'

  root 'overview#index'
  resources :strategies
  resources :indicators
  resources :companies
  
end
