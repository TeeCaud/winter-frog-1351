Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :plots, only: [:index]
  resources :gardens, only: [:show]
  resources :plant_plots, only: [:destroy]

  # delete "/plots/:id/plants/:plant_plot_id", to: 'plant_plots#destroy'
end
