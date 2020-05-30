Rails.application.routes.draw do
  resources :job_posts

  root to: redirect("/job_posts")
end
