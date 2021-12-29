require "test_helper"

class JobPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_post = job_posts(:one)
  end

  test "should get index" do
    get job_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_job_post_url
    assert_response :success
  end

  test "should create job_post" do
    assert_difference("JobPost.count") do
      post job_posts_url, params: { job_post: { body: @job_post.body, title: @job_post.title } }
    end

    assert_redirected_to job_post_url(JobPost.last)
  end

  test "should show job_post" do
    get job_post_url(@job_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_post_url(@job_post)
    assert_response :success
  end

  test "should update job_post" do
    patch job_post_url(@job_post), params: { job_post: { body: @job_post.body, title: @job_post.title } }
    assert_redirected_to job_post_url(@job_post)
  end

  test "should destroy job_post" do
    assert_difference("JobPost.count", -1) do
      delete job_post_url(@job_post)
    end

    assert_redirected_to job_posts_url
  end
end
