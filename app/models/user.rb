class User < ApplicationRecord
  include Clearance::User

  has_many :job_posts
  has_many :job_applications, dependent: :destroy
end
