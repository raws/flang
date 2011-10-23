Flang::Application.routes.draw do
  root :to => "commands#index"
  
  get "sign_in" => "session#new"
  post "sign_in" => "session#create"
  match "sign_out" => "session#destroy"
  
  resources :commands
end
