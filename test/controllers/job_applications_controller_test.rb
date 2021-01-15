require 'test_helper'

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  let(:job_post) { FactoryBot.create(:job_post) }

  describe 'as an admin' do
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:job_application) { FactoryBot.create(:job_application, job_post: job_post) }

    test 'should get index' do
      get job_post_job_applications_url(as: admin, job_post_id: job_post.id)
      assert_response :success
    end

    test 'should show job_application' do
      get job_post_job_application_url(as: admin, job_post_id: job_post.id, id: job_application.id)
      assert_response :success
    end

    test 'should get edit' do
      get edit_job_post_job_application_url(as: admin, job_post_id: job_post.id, id: job_application.id)
      assert_response :success
    end

    test 'should update job_application' do
      patch job_post_job_application_url(as: admin, job_post_id: job_post.id, id: job_application.id), params: { job_application: { body: 'Updated application' } }
      assert_redirected_to job_post_url(job_post)
    end

    test 'should destroy job_application' do
      job_application # We need to create the job application for assert_difference to work

      assert_difference('JobApplication.count', -1) do
        delete job_post_job_application_url(as: admin, job_post_id: job_post.id, id: job_application.id)
      end

      assert_redirected_to job_post_url(job_post)
    end
  end

  describe 'as a user' do
    let(:user) { FactoryBot.create(:user) }

    test 'should get new' do
      get new_job_post_job_application_url(as: user, job_post_id: job_post.id)
      assert_response :success
    end

    test 'should create job_application' do
      assert_difference('JobApplication.count') do
        post job_post_job_applications_url(as: user, job_post_id: job_post.id), params: { job_application: { body: 'I am applying' } }
      end

      assert_redirected_to job_post_url(job_post)
    end
  end
end
