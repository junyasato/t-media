Rails.application.routes.draw do
   # root
   root 'articles#index'
   #
   get  '/articles/add_text'   => 'articles#add_text'
   get  '/articles/add_header' => 'articles#add_header'
   get  '/articles/add_quote'  => 'articles#add_quote'
   get  '/articles/add_button' => 'articles#add_button'
   get  '/articles/add_image'  => 'articles#add_image'
   get  '/articles/save'       => 'articles#save'
   # resources
   resources :articles
   resources :categories
   resources :items
end
