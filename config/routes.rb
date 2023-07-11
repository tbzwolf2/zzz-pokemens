Rails.application.routes.draw do
  get "/setup", to: "setup#setup"

  # Only do the actions we are going to service
  scope :except => [:patch, :destroy, :put, :post] do
    namespace :api do 
      namespace :v1 do 
        resources :pokemon, :only => [:show, :index]
      end
    end
  end

end
