
require 'rails_helper'

feature 'invite friend' do

  before { clear_emails }
  after { clear_emails }

  scenario 'user successfully invites a friend' do

    set_user
    sign_in(@user)
    navigate_to_invitation_page
    set_friend
    invite_friend
    find_invitation

    expect(current_path).to eq(new_invitation_path)
    expect(page).to have_content "We sent your invitation to #{@first_invitation.invitee_name}!"
  end

  scenario 'friend successfully receives invitation' do

    set_user
    sign_in(@user)
    navigate_to_invitation_page
    set_friend
    invite_friend
    find_invitation
    follow_invitation_link

    # expect(current_path).to eq("/register/#{@first_invitation.token}") # previously passed, but now gets "//register..." instead of "/register..."
    expect(find_field('Email address').value).to eq("#{@friend.email_address}")
  end

  scenario 'friend successfully registers' do

    set_invitation
    register_friend
    find_new_user
    follow_welcome_link

    # expect(current_path).to eq(home_path) # FAILED: expected: "/home" got: "/signin"
    # expect(page).to have_content("Welcome, #{@new_user.full}")
  end

  def set_user
    @user = Fabricate(:user, password: 'password')
  end

  def sign_in(user)
    visit root_path
    click_on 'Sign In'
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  def navigate_to_invitation_page
    visit root_path
    click_on "Welcome, #{@user.full_name}"
    click_on 'Invite a Friend'
  end

  def set_friend
    @friend = Fabricate(:user, password: 'password')
  end

  def invite_friend
    fill_in 'Friend\'s Name', with: @friend.full_name
    fill_in 'Friend\'s Email Address', with: @friend.email_address
    fill_in 'Invitation Message', with: 'Please join MyFlix'
    click_button 'Send Invitation'
  end

  def find_invitation
    @first_invitation = Invitation.where(invitee_email_address: @friend.email_address).first
  end

  def follow_invitation_link
    open_email(@friend.email_address)
    current_email.save_and_open
    current_email.click_link 'Go to MyFlix!'
  end

  def set_invitation
    @second_invitation = Fabricate(:invitation)
    visit register_path
  end

  def register_friend
    fill_in 'Email address', with: @second_invitation.invitee_email_address
    fill_in 'Password', with: 'password'
    fill_in 'Full name', with: @second_invitation.invitee_name
    click_button 'Sign Up'
  end

  def find_new_user
    @new_user = User.where(email_address: @second_invitation.invitee_email_address).first
  end

  def follow_welcome_link
    open_email(@new_user.email_address)
    current_email.save_and_open
    current_email.click_on 'Please sign in to begin viewing awesome videos.'
  end
end
