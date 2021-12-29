Rails.application.routes.draw do
  resources :job_posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: redirect("/job_posts")
end
