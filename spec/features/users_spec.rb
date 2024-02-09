require 'rails_helper'

RSpec.describe 'Splash screen', type: :feature do
  before :each do
    visit '/'
  end

  it 'Displays the app title' do
    expect(page).to have_content 'Budget Trackie'
  end

  it 'Can create a new user' do
    click_link 'Sign Up'

    expect(page).to have_current_path(new_user_registration_path)
  end

  it 'Can log in' do
    click_link 'Log In'

    expect(page).to have_current_path(new_user_session_path)
  end
end
