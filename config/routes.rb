Rails.application.routes.draw do
  root to: 'admin/batch_direct_transactions#index'

  namespace :admin do
    root to: 'batch_direct_transactions#index'
    resources :batch_direct_transactions do
      member do
        get '/response', to: 'batch_direct_transactions#show_single'
        put '/regenerate', to: 'batch_direct_transactions#regenerate_single'
      end
    end
  end
end
