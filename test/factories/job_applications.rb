FactoryBot.define do
  factory :job_application do
    body { "I'd like to apply for this job" }

    user
    job_post
  end
end
