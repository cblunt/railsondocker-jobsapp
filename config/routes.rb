Rails.application.routes.draw do
  resources :job_posts do
    resources :job_applications
  end

  root to: redirect("/job_posts")
end
