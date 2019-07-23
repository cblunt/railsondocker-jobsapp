class JobPost < ApplicationRecord
  has_many :job_applications
  has_many :applicants, through: :job_applications

  validates :title, presence: true
  validates :body, presence: true
end
