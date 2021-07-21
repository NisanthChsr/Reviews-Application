Rails.application.routes.draw do
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies,:books,:users,:posts,:comments,:categories,:songs

  post 'authenticate', to: 'authentication#authenticate'
  get ':commentable_name/:commentable_id/users/:user_id/posts', to: 'posts#custom_show'
  post ':commentable_name/:commentable_id/posts', to: 'posts#create'
  get ':category_name/:category_id/users/:user_id/posts/:post_id/comments', to: 'comments#show_by_posts_users'
  get ':category_name/:category_id/posts/:post_id/comments', to: 'comments#show_by_posts'
  post ':category_name/:category_id/posts/:post_id/comments', to: 'comments#create'
end
