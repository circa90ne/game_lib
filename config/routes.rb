Rails.application.routes.draw do
  root to: "v1/categories#index"
  scope :v1 do
    resources :games, controller: 'v1/games' do
      get 'search', on: :collection
    end
    resources :categories, controller: 'v1/categories'
    # get only the games for specific category
    get '/games/categories/:category_id' => 'v1/games#find_by_category'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
