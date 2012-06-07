Blog::Application.routes.draw do

  resources :users, :except => [:new, :create, :index] do
    get 'toggle_poker_player', :on => :member
  end

  resources :posts do
    resources :comments
  end
  match '/feed' => 'news_items#feed', :as => :feed, :defaults => { :format => 'atom' }

  resources :albums do
    resources :photos
  end
  match 'picture_frame' => 'picture_frame#show', :as => 'picture_frame'
  match 'picture_frame/:id/update' => 'picture_frame#update', :as => 'picture_frame_update'

  resources :tournaments, :except => [:edit, :update] do
    get 'rsvp', :on => :member
  end

  resources :players, :only => :update

  #omniauth
  match "/auth/:provider/callback" => 'sessions#create'
  match "/signout" => 'sessions#destroy', :as => :signout

  root :to => 'posts#index', :as => :home
end
