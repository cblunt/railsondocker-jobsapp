# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# frozen_string_literal: true

# Create a root admin user to log in
admin = User.where(email: 'admin@example.com').first_or_create! do |u|
  u.first_name = 'Admin'
  u.last_name = 'User'
  u.admin = true
  u.password = 'secret123'
end

# Create some example job posts
job1 = JobPost.where(title: 'Barista').first_or_create! do |post|
  post.body = "We're looking for a barista to join our team!"
end

job2 = JobPost.where(title: 'Office Manager').first_or_create! do |post|
  post.body = 'Manage our office'
end

job3 = JobPost.where(title: 'Marketing Assistant').first_or_create! do |post|
  post.body = 'Help build our marketing strategy'
end

# Create some job applicants
(1..4).each do |n|
  User.where(email: "applicant#{n}@example.com").first_or_create! do |u|
    u.first_name = 'Applicant'
    u.last_name = n.to_s
    u.admin = false
    u.password = 'secret123'
  end
end

# Create some job applications for the posts
JobApplication.where(job_post: job1, user: User.find_by(email: 'applicant1@example.com')) do |jobapp|
  jobapp.body = "Hi! I'm applying for this job."
end

JobApplication.where(job_post: job1, user: User.find_by(email: 'applicant2@example.com')) do |jobapp|
  jobapp.body = "I'd like to apply for this position."
end

JobApplication.where(job_post: job2, user: User.find_by(email: 'applicant3@example.com')) do |jobapp|
  jobapp.body = 'Consider me for this job.'
end

JobApplication.where(job_post: job2, user: User.find_by(email: 'applicant4@example.com')) do |jobapp|
  jobapp.body = 'Please consider my application for this opportunity.'
end
