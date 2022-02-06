require "application_system_test_case"

class JobPostsTest < ApplicationSystemTestCase
  let(:admin) { FactoryBot.create(:user, :admin) }

  test 'creating a Job Post' do
    visit job_posts_url(as: admin)

    click_on 'New job post'

    fill_in 'Title', with: 'A Job Post'
    fill_in 'Body', with: 'Work for us at our company.'

    click_on 'Create Job post'

    expect(text).must_match(/Job post was successfully created/)
  end
end
