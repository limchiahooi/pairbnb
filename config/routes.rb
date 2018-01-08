Rails.application.routes.draw do
  

root "listings#index"


  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]



  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end







   resources :users
   resources :listings
   resources :reservations, only: [:destroy]


    resources :users do
       resources :listings
    end

     resources :listings do
        resources :image, :only => [:create, :destroy] # support #create and #destroy
      end


     resources :listings do
       resources :reservations, only: [:create]
    end





post "/users/:user_id/listings/:id/verify" => "listings#verify"
post "/users/:user_id/listings/:id/unverify" => "listings#unverify"






  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end





# nextacademy@nextacademy-VirtualBox:~/Desktop/git-test/pairbnb$ rails routes
#             Prefix Verb   URI Pattern                                 Controller#Action
#               root GET    /                                           listings#index
#          passwords POST   /passwords(.:format)                        clearance/passwords#create
#       new_password GET    /passwords/new(.:format)                    clearance/passwords#new
#            session POST   /session(.:format)                          clearance/sessions#create
# edit_user_password GET    /users/:user_id/password/edit(.:format)     clearance/passwords#edit
#      user_password PATCH  /users/:user_id/password(.:format)          clearance/passwords#update
#                    PUT    /users/:user_id/password(.:format)          clearance/passwords#update
#                    POST   /users/:user_id/password(.:format)          clearance/passwords#create
#              users POST   /users(.:format)                            clearance/users#create
#      user_listings GET    /users/:user_id/listings(.:format)          listings#index
#                    POST   /users/:user_id/listings(.:format)          listings#create
#   new_user_listing GET    /users/:user_id/listings/new(.:format)      listings#new
#  edit_user_listing GET    /users/:user_id/listings/:id/edit(.:format) listings#edit
#       user_listing GET    /users/:user_id/listings/:id(.:format)      listings#show
#                    PATCH  /users/:user_id/listings/:id(.:format)      listings#update
#                    PUT    /users/:user_id/listings/:id(.:format)      listings#update
#                    DELETE /users/:user_id/listings/:id(.:format)      listings#destroy
#                    GET    /users(.:format)                            users#index
#                    POST   /users(.:format)                            users#create
#           new_user GET    /users/new(.:format)                        users#new
#          edit_user GET    /users/:id/edit(.:format)                   users#edit
#               user GET    /users/:id(.:format)                        users#show
#                    PATCH  /users/:id(.:format)                        users#update
#                    PUT    /users/:id(.:format)                        users#update
#                    DELETE /users/:id(.:format)                        users#destroy
#           listings GET    /listings(.:format)                         listings#index
#                    POST   /listings(.:format)                         listings#create
#        new_listing GET    /listings/new(.:format)                     listings#new
#       edit_listing GET    /listings/:id/edit(.:format)                listings#edit
#            listing GET    /listings/:id(.:format)                     listings#show
#                    PATCH  /listings/:id(.:format)                     listings#update
#                    PUT    /listings/:id(.:format)                     listings#update
#                    DELETE /listings/:id(.:format)                     listings#destroy
#            sign_in GET    /sign_in(.:format)                          clearance/sessions#new
#           sign_out DELETE /sign_out(.:format)                         sessions#destroy
#            sign_up GET    /sign_up(.:format)                          clearance/users#new
#                    GET    /auth/:provider/callback(.:format)          sessions#create_from_omniauth

