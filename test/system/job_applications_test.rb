require 'application_system_test_case'

class JobApplicationsTest < ApplicationSystemTestCase
  let(:user) { FactoryBot.create(:user) }
  let(:job_post) { FactoryBot.create(:job_post) }

  test 'applying for a job' do
    visit job_post_url(as: user, id: job_post.id)

    click_on 'Apply Now'

    fill_in 'Body', with: 'I would like to apply for this job'

    attach_file 'Cv', fixture_file_path('sample_cv.pdf')

    click_on 'Create Job application'

    assert_text 'Job application was successfully created'
    click_on 'Back'
  end

  describe 'as an admin' do
    let(:job_post) { FactoryBot.create(:job_post, title: 'A Job Post') }
    let(:admin) { FactoryBot.create(:user, :admin) }

    setup do
      FactoryBot.create(:job_application, user: user, body: 'I would like this job', cv: fixture_file_upload('files/sample_cv.pdf'), job_post: job_post)
    end

    test "viewing a job post's applications" do
      visit job_posts_url(as: admin)

      assert_link 'Applications'

      click_on 'Applications'

      assert_text 'Job Applications for A Job Post'

      assert_text 'I would like this job'
      assert_text 'user@example.com'

      click_on 'Show'

      assert_text 'Application for A Job Post'
      assert_text 'Applicant: user@example.com'
      assert_text 'Body: I would like this job'
      assert_text 'Attached CV'
      assert_link 'Download'

      click_on 'Back'
    end

    test 'destroying a Job application' do
      visit job_post_job_applications_url(as: admin, job_post_id: job_post.id)

      page.accept_confirm do
        click_on 'Destroy'
      end

      assert_text 'Job application was successfully destroyed'
    end
  end
end
