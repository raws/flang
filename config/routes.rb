Flang::Application.routes.draw do
  root :to => "session#new"
  
  get "sign_in" => "session#new"
  post "sign_in" => "session#create"
  match "sign_out" => "session#destroy"
end
