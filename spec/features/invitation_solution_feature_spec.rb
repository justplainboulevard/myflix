
require 'rails_helper'

feature 'invite friend' do

  after { clear_emails }

  scenario 'user successfully invites a friend and the friend accepts the invitation' do

    @user = Fabricate(:user)
    visit root_path
    sign_in(@user)
    user_invites_friend
    friend_accepts_invitation
    # friend_signs_in # See note below.
    friend_should_follow_user
    user_should_follow_friend
  end

  def sign_in(user)
    click_link 'Sign In'
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  # NB: My initial unsophisticated method. Works, but not as elegant.
  # def sign_out
  #   click_link 'Welcome'
  #   click_link 'Sign Out'
  # end

  def sign_out
    visit signout_path
  end

  def user_invites_friend
    visit new_invitation_path
    fill_in 'Friend\'s Name', with: 'William Tecumseh Sherman'
    fill_in 'Friend\'s Email Address', with: 'williet@example.com'
    fill_in 'Invitation Message', with: 'Please join MyFlix'
    click_button 'Send Invitation'
    sign_out
  end

  def friend_accepts_invitation
    open_email 'williet@example.com'
    current_email.click_link 'Go to MyFlix!'
    fill_in 'Password', with: 'password'
    fill_in 'Full name', with: 'William Tecumseh Sherman'
    click_button 'Sign Up'
  end

  # NB: My code automatically signs in a new user upon successful registration.
  # def friend_signs_in
    # fill_in 'Email address', with: 'williet@example.com'
    # fill_in 'Password', with: 'password'
    # click_button 'Sign In'
  # end

  def friend_should_follow_user
    click_link 'People'
    expect(page).to have_content @user.full_name
    sign_out
  end

  def user_should_follow_friend
    sign_in(@user)
    click_link 'People'
    expect(page).to have_content 'William Tecumseh Sherman'
  end
end
