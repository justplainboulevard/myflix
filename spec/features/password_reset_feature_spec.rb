
require 'rails_helper'

feature 'password reset' do

  background do

    @user = Fabricate(:user, email_address: 'user@example.com', password: 'password')
    clear_emails
    visit forgot_password_path
  end

  after { ActionMailer::Base.deliveries.clear }

  scenario 'request password reset with valid email address' do

    fill_in 'Email Address', with: 'user@example.com'
    click_button 'Send Email'

    expect(current_path).to eq(password_reset_confirmation_path)
    expect(page).to have_content 'Please check your inbox. We just sent instructions for resetting your password to the email address you submitted.'
  end

  scenario 'request password reset with invalid email address' do

    fill_in 'Email Address', with: 'wrong_user@example.com'
    click_button 'Send Email'

    expect(current_path).to eq(forgot_password_path)
    expect(page).to have_content 'You submitted an invalid email address.'
  end

  scenario 'request password reset with no email address' do

    click_button 'Send Email'

    expect(current_path).to eq(forgot_password_path)
    expect(page).to have_content 'Email address cannot be blank.'
  end

  scenario 'receive password reset email' do

    fill_in 'Email Address', with: 'user@example.com'
    click_button 'Send Email'
    open_email('user@example.com')

    expect(current_email).to have_content 'Reset my password.'
  end

  scenario 'follow password reset link' do

    fill_in 'Email Address', with: 'user@example.com'
    click_button 'Send Email'
    open_email('user@example.com')
    current_email.click_link 'Reset my password.'

    expect(current_path).to eq(password_reset_path(@user.token))
    expect(page).to have_content 'Reset Your Password'
  end

  scenario 'view email body in browser' do

    fill_in 'Email Address', with: 'user@example.com'
    click_button 'Send Email'
    open_email('user@example.com')
    current_email.click_link 'Reset my password.'

    current_email.save_and_open
  end
end
