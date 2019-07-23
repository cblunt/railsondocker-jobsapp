require "application_system_test_case"

class JobPostsTest < ApplicationSystemTestCase
  let(:admin) { FactoryBot.create(:user, :admin) }

  describe "public user not signed in" do
    setup do
      FactoryBot.create(:job_post)
    end

    test "viewing job posts" do
      visit job_posts_url

      assert_text "Job Posts"
      assert_text "A Job Post"

      click_on "Show"

      click_on "Apply Now"

      assert_text "Sign in"
    end
  end

  test "creating a Job Post" do
    visit job_posts_url(as: admin)

    click_on "New Job Post"

    fill_in "Title", with: "A Job Post"
    fill_in "Body", with: "Work for us at our company."

    click_on "Create Job post"

    assert_text "Job post was successfully created"
    click_on "Back"
  end

  describe "modifying a job post" do
    setup do
      FactoryBot.create(:job_post)
    end

    test "updating a Job post" do
      visit job_posts_url(as: admin)

      click_on "Edit"

      fill_in "Title", with: "An Updated Job"
      fill_in "Body", with: "We're updating the job post"

      click_on "Update Job post"

      assert_text "Job post was successfully updated"

      click_on "Back"
    end

    test "destroying a Job post" do
      visit job_posts_url(as: admin)

      page.accept_confirm do
        click_on "Destroy"
      end

      assert_text "Job post was successfully destroyed"
    end
  end
end
