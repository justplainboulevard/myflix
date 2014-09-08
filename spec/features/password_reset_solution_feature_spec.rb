
require 'rails_helper'

feature 'password reset' do

  scenario 'user successfully resets password' do

    set_user
    clear_emails
    request_reset_password_email
    follow_reset_password_link
    reset_password
    sign_in

    expect(current_path).to eq(home_path)
    expect(page).to have_content "You are now signed in as #{@user.full_name}."
  end

  def set_user

    @user = Fabricate(:user, password: 'old_password')
  end

  def request_reset_password_email

    visit signin_path
    click_link 'Forgot password?'
    fill_in 'Email Address', with: @user.email_address
    click_button 'Send Email'
  end

  def follow_reset_password_link

    open_email(@user.email_address)
    current_email.click_link 'Reset my password.'
  end

  def reset_password

    fill_in 'New Password', with: 'new_password'
    click_button 'Reset Password'
  end

  def sign_in

    fill_in 'Email address', with: @user.email_address
    fill_in 'Password', with: 'new_password'
    click_button 'Sign In'
  end
end
