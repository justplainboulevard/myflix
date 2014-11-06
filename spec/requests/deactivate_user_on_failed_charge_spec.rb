
require 'rails_helper'

RSpec.describe 'deactivate user on failed charge', type: :request do

  let(:event_data) do
    {
      'id' => 'evt_14vramFYOxyDZoxzFsZyrdrq',
      'created' => 1415285432,
      'livemode' => false,
      'type' => 'charge.failed',
      'data' => {
        'object' => {
          'id' => 'ch_14vramFYOxyDZoxzBC6qyUq0',
          'object' => 'charge',
          'created' => 1415285432,
          'livemode' => false,
          'paid' => false,
          'amount' => 2500,
          'currency' => 'usd',
          'refunded' => false,
          'card' => {
            'id' => 'card_14vraGFYOxyDZoxzrQOeERvE',
            'object' => 'card',
            'last4' => '0341',
            'brand' => 'Visa',
            'funding' => 'credit',
            'exp_month' => 11,
            'exp_year' => 2017,
            'fingerprint' => '5bpQSxiu0uc63xbC',
            'country' => 'US',
            'name' => nil,
            'address_line1' => nil,
            'address_line2' => nil,
            'address_city' => nil,
            'address_state' => nil,
            'address_zip' => nil,
            'address_country' => nil,
            'cvc_check' => 'pass',
            'address_line1_check' => nil,
            'address_zip_check' => nil,
            'dynamic_last4' => nil,
            'customer' => 'cus_55nncIEKWDvmti'
          },
          'captured' => false,
          'refunds' => {
            'object' => 'list',
            'total_count' => 0,
            'has_more' => false,
            'url' => '/v1/charges/ch_14vramFYOxyDZoxzBC6qyUq0/refunds',
            'data' => []
          },
          'balance_transaction' => nil,
          'failure_message' => 'Your card was declined.',
          'failure_code' => 'card_declined',
          'amount_refunded' => 0,
          'customer' => 'cus_55nncIEKWDvmti',
          'invoice' => nil,
          'description' => 'set to fail',
          'dispute' => nil,
          'metadata' => {},
          'statement_description' => nil,
          'fraud_details' => {
            'stripe_report' => nil,
            'user_report' => nil
          },
          'receipt_email' => nil,
          'receipt_number' => nil,
          'shipping' => nil
        }
      },
      'object' => 'event',
      'pending_webhooks' => 2,
      'request' => 'iar_563iOdEs9HHRQa',
      'api_version' => '2014-10-07'
    }
  end

  let!(:subject_user) { Fabricate(:user, customer_token: 'cus_55nncIEKWDvmti') }

  before :each do
    post '/stripe_events', event_data
  end

  it 'deactivates the subject user with the webhook from stripe for charge failed' do
    expect(subject_user.reload).not_to be_active
  end
end