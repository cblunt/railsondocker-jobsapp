require "application_system_test_case"

class JobApplicationsTest < ApplicationSystemTestCase
  let(:applicant) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }

  let(:job_application) { FactoryBot.create(:job_application) }
  let(:job_post) { FactoryBot.create(:job_post) }

  test "visiting the index" do
    visit job_post_job_applications_url(job_post, as: admin)

    assert_selector "h1", text: "Job applications"
  end

  test "should create job application" do
    visit job_post_url(job_post, as: applicant)

    click_on "Apply Now"

    fill_in "Body", with: "I would like to apply for this job"
    attach_file "Cv", "test/fixtures/files/sample.txt"

    click_on "Create Job application"

    expect(text).must_match("Job application was successfully created")

    click_on "Back"
  end

  test "should update Job application" do
    visit job_post_job_application_url(job_application.job_post, job_application, as: admin)

    click_on "Edit this job application", match: :first
    fill_in "Body", with: job_application.body
    attach_file "Cv", "test/fixtures/files/sample.txt"
    click_on "Update Job application"

    expect(text).must_match("Job application was successfully updated")

    click_on "Back"
  end

  test "should destroy Job application" do
    visit job_post_job_application_url(job_application.job_post, job_application, as: admin)

    click_on "Destroy this job application", match: :first

    expect(text).must_match("Job application was successfully destroyed")
  end
end
