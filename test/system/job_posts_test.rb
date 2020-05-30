require "application_system_test_case"

class JobPostsTest < ApplicationSystemTestCase
  setup do
    @job_post = job_posts(:one)
  end

  test "visiting the index" do
    visit job_posts_url
    assert_selector "h1", text: "Job Posts"
  end

  test "creating a Job post" do
    visit job_posts_url
    click_on "New Job Post"

    fill_in "Body", with: @job_post.body
    fill_in "Title", with: @job_post.title
    click_on "Create Job post"

    assert_text "Job post was successfully created"
    click_on "Back"
  end

  test "updating a Job post" do
    visit job_posts_url
    click_on "Edit", match: :first

    fill_in "Body", with: @job_post.body
    fill_in "Title", with: @job_post.title
    click_on "Update Job post"

    assert_text "Job post was successfully updated"
    click_on "Back"
  end

  test "destroying a Job post" do
    visit job_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job post was successfully destroyed"
  end
end
