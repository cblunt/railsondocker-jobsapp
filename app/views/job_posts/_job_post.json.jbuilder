json.extract! job_post, :id, :title, :body, :created_at, :updated_at
json.url job_post_url(job_post, format: :json)
