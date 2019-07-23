class JobApplication < ApplicationRecord
  belongs_to :job_post
  belongs_to :user

  has_one_attached :cv

  validates :body, presence: true
end
