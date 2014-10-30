
require 'rails_helper'

RSpec.describe 'create payment on successful charge', type: :request do

  let(:event_data) do
    {
      "id" => "evt_14tNQ5FYOxyDZoxzux6jgJdf",
      "created" => 1414692793,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_14tNQ5FYOxyDZoxzjcKshT78",
          "object" => "charge",
          "created" => 1414692793,
          "livemode" => false,
          "paid" => true,
          "amount" => 1500,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_14tNQ4FYOxyDZoxzBm2iUDDa",
            "object" => "card",
            "last4" => "0000",
            "brand" => "JCB",
            "funding" => "credit",
            "exp_month" => 10,
            "exp_year" => 2018,
            "fingerprint" => "DLm4zluqJGUTS9Fr",
            "country" => "JP",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "dynamic_last4" => nil,
            "customer" => "cus_53UO0LG3VI6X6e"
          },
          "captured" => true,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" => "/v1/charges/ch_14tNQ5FYOxyDZoxzjcKshT78/refunds",
            "data" => [

            ]
          },
          "balance_transaction" => "txn_14tNQ5FYOxyDZoxzX7Ne0UYM",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_53UO0LG3VI6X6e",
          "invoice" => "in_14tNQ5FYOxyDZoxzfC7AqTbD",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {
          },
          "statement_description" => "MYFLIX BASIC+",
          "fraud_details" => {
            "stripe_report" => nil,
            "user_report" => nil
          },
          "receipt_email" => nil,
          "receipt_number" => nil,
          "shipping" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_53UONYSCTOb5A1"
    }
  end

  before :each do
    post '/stripe_events', event_data
  end

  it 'creates a payment with the webhook from stripe for charge succeeded' do
    expect(Payment.count).to eq(1)
  end

  it 'creates a payment associated with the correct user' do
    subject_user = Fabricate(:user, customer_token: 'cus_53UO0LG3VI6X6e')
    expect(Payment.first.user).to eq(subject_user)
  end

  it 'creates a payment of the correct amount' do
    expect(Payment.first.amount).to eq(1500)
  end
end
