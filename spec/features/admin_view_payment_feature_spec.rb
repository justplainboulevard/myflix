
require 'rails_helper'

RSpec.feature 'view payment' do

  scenario 'admin user can view payments' do

    subscriber = Fabricate(:user, email_address: 'williet@example.com', full_name: 'William Tecumseh Sherman')
    payment = Fabricate(:payment, amount: 1000, user_id: subscriber.id)
    admin_user = Fabricate(:admin)

    visit signin_path
    fill_in 'Email address', with: admin_user.email_address
    fill_in 'Password', with: admin_user.password
    click_button 'Sign In'

    visit admin_payments_path

    expect(page).to have_content('10.00')
    expect(page).to have_content('williet@example.com')
    expect(page).to have_content('William Tecumseh Sherman')
  end

  scenario 'non-admin user cannot view payments' do

    subscriber = Fabricate(:user, email_address: 'williet@example.com', full_name: 'William Tecumseh Sherman')
    payment = Fabricate(:payment, amount: 1000, user_id: subscriber.id)
    user = Fabricate(:user)

    visit signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit admin_payments_path

    expect(page).not_to have_content('10.00')
    expect(page).not_to have_content('williet@example.com')
    expect(page).not_to have_content('William Tecumseh Sherman')
    expect(page).to have_content('Access denied! You cannot take that action.')
  end
end
