
require 'rails_helper'

feature 'visitor registers', js: true do

  let(:email_address) { 'williet@example.com' }
  let(:password) { 'password' }
  let(:full_name) { 'William Tecumseh Sherman' }

  # Test card numbers available from Stripe:
  let(:visa_credit_card_1) { '4242424242424242' }
  let(:visa_credit_card_2) { '4012888888881881' }
  let(:visa_debit_card) { '4000056655665556' }
  let(:mastercard_credit_card) { '5555555555554444' }
  let(:mastercard_debit_card) { '5200828282828210' }
  let(:mastercard_prepaid_card) { '5105105105105100' }
  let(:american_express_credit_card_1) { '378282246310005' }
  let(:american_express_credit_card_2) { '371449635398431' }
  let(:discover_credit_card_1) { '6011111111111117' }
  let(:discover_credit_card_2) { '6011000990139424' }
  let(:diners_club_credit_card_1) { '30569309025904' }
  let(:diners_club_credit_card_2) { '38520000023237' }
  let(:jcb_credit_card_1) { '3530111333300000' }
  let(:jcb_credit_card_2) { '3566002020360505' }
  let(:card_declined) { '4000000000000002' }
  let(:incorrect_cvc) { '4000000000000127' }
  let(:expired_card) { '4000000000000069' }
  let(:processing_error) { '4000000000000119' }
  let(:incorrect_number) { '4242424242424241' }

  background { visit register_path }

  scenario 'without an email address' do

    register_visitor(nil, password, full_name, visa_credit_card_1)

    expect(page).to have_content 'Email address can\'t be blank'
  end

  scenario 'without a password' do

    register_visitor(email_address, nil, full_name, visa_credit_card_1)

    expect(page).to have_content 'Password can\'t be blank'
  end

  scenario 'without a full name' do

    register_visitor(email_address, password, nil, visa_credit_card_1)

    expect(page).to have_content 'Full name can\'t be blank'
  end

  scenario 'with a Visa credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, visa_credit_card_1)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a second Visa credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, visa_credit_card_2)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a Visa debit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, visa_debit_card)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a MasterCard credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, mastercard_credit_card)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a MasterCard debit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, mastercard_debit_card)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a MasterCard prepaid card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, mastercard_prepaid_card)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a American Express credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, american_express_credit_card_1)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a second American Express credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, american_express_credit_card_2)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a Discover credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, discover_credit_card_1)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a second Discover credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, discover_credit_card_2)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a Diners Club credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, diners_club_credit_card_1)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a second Diners Club credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, diners_club_credit_card_2)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a JCB credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, jcb_credit_card_1)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a second JCB credit card that has a valid number, and is accepted' do

    register_visitor(email_address, password, full_name, jcb_credit_card_2)

    expect(page).to have_content 'You are now registered as William Tecumseh Sherman. Welcome to MyFlix!'
  end

  scenario 'with a credit card that has an incorrect number' do

    register_visitor(email_address, password, full_name, incorrect_number)

    expect(page).to have_content 'Your card number is incorrect.'
  end

  scenario 'with a credit card that has a correct number, but is declined' do

    register_visitor(email_address, password, full_name, card_declined)

    expect(page).to have_content 'Your card was declined.'
  end

  scenario 'with a credit card that has a correct number, but is declined with an incorrect cvc code' do

    register_visitor(email_address, password, full_name, incorrect_cvc)

    expect(page).to have_content 'Your card\'s security code is incorrect.'
  end

  scenario 'with a credit card that has a correct number, but is declined with an expired card code' do

    register_visitor(email_address, password, full_name, expired_card)

    expect(page).to have_content 'Your card has expired.'
  end

  # EXAMPLE: Override Capybara Javascript driver specified in rails_helper.rb (:webkit) with :selenium.

  scenario 'with a credit card that has a correct number, but is declined with a processing error code', driver: :selenium do

    register_visitor(email_address, password, full_name, processing_error)

    expect(page).to have_content 'An error occurred while processing your card. Try again in a little bit.'
  end
end


def register_visitor(email_address, password, full_name, card_number)

  fill_in 'Email address', with: email_address
  fill_in 'Password', with: password
  fill_in 'Full name', with: full_name
  fill_in 'Credit card number', with: card_number
  fill_in 'Security code', with: '123'
  select '1 - January', from: 'date_month'
  select '2016', from: 'date_year'
  click_button 'Sign up'
end
