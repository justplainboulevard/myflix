
require 'rails_helper'

RSpec.feature 'user signs in', type: :feature do

  let(:user) { Fabricate(:user) }

  scenario 'with valid credentials' do

    visit signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'You are now signed in'
  end

  scenario 'with valid credentials' do

    visit signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content user.full_name
  end

  scenario 'with invalid email address' do

    visit signin_path
    fill_in 'Email address', with: 'wrong@email.net'
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'The username or password that you provided is incorrect'
  end

  scenario 'with invalid password' do

    visit signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: 'wrong password'
    click_button 'Sign In'

    expect(page).to have_content 'The username or password that you provided is incorrect'
  end

  scenario 'when inactive' do

    inactive_user = Fabricate(:user, active: false)

    visit signin_path
    fill_in 'Email address', with: inactive_user.email_address
    fill_in 'Password', with: inactive_user.password
    click_button 'Sign In'

    expect(page).to have_content 'Your account has been suspended. Please contact customer service.'
  end
end
