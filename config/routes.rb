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
  match 'picture_frame/show' => 'picture_frame#show', :as => 'picture_frame_show'

  resources :tournaments

  #omniauth
  match "/auth/:provider/callback" => 'sessions#create'
  match "/signout" => 'sessions#destroy', :as => :signout

  root :to => 'posts#index', :as => :home
end
