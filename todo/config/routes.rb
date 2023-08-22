Rails.application.routes.draw do
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "main#index"
  
  scope module: :users do 
    get LinkConfig::LINKS[:signup], to: "signup#new"
    post LinkConfig::LINKS[:signup], to: "signup#create"
    get LinkConfig::LINKS[:login], to: "login#new"
    post LinkConfig::LINKS[:login], to: "login#create"
    delete LinkConfig::LINKS[:logout], to: "logout#destroy"
    
    get LinkConfig::LINKS[:user_list], to: "index#index", as: "user_list"
    get LinkConfig::LINKS[:user_detail] + "/:id", to: "index#show"
    
    get LinkConfig::LINKS[:user_edit] + "/:id", to: "index#edit"
    post LinkConfig::LINKS[:user_edit] + "/:id", to: "index#update"
    delete LinkConfig::LINKS[:user_list], to: "index#delete"
  end
  
  namespace :posts do
    get LinkConfig::LINKS[:post_list], to: "/posts#index", as: "list"
    get LinkConfig::LINKS[:post_detail] + "/:id", to: "/posts#show", as: "show"
    get LinkConfig::LINKS[:post_create], to: "/posts#new", as: "new"
    post LinkConfig::LINKS[:post_create], to: "/posts#create", as: "create"
    
    get LinkConfig::LINKS[:post_edit] + "/:id", to: "/posts#edit", as: "edit"
    post LinkConfig::LINKS[:post_edit] + "/:id", to: "/posts#update", as: "update"
    delete LinkConfig::LINKS[:post_list], to: "/posts#delete", as: "delete"
  end
end
