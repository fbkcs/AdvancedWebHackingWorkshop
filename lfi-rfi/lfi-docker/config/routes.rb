RailsRce::Application.routes.draw do
  get 'users/:id', to: 'user#show'
end
