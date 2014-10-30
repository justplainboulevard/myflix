
require 'rails_helper'

RSpec.describe 'create payment on successful charge', type: :request do

  let(:event_data) do
    {
      "id" => "evt_14t1cbFYOxyDZoxzaIyPO0kB",
      "created" => 1414609001,
      "livemode" => false,
      "type" => "invoice.created",
      "data" => {
        "object" => {
          "date" => 1414609001,
          "id" => "in_14t1cbFYOxyDZoxzciYaYqPd",
          "period_start" => 1414609001,
          "period_end" => 1414609001,
          "lines" => {
            "object" => "list",
            "total_count" => 1,
            "has_more" => false,
            "url" => "/v1/invoices/in_14t1cbFYOxyDZoxzciYaYqPd/lines",
            "data" => [
              {
                "id" => "sub_537ss6olixdgsQ",
                "object" => "line_item",
                "type" => "subscription",
                "livemode" => false,
                "amount" => 0,
                "currency" => "usd",
                "proration" => false,
                "period" => {
                  "start" => 1414609001,
                  "end" => 1417201001
                },
                "subscription" => nil,
                "quantity" => 1,
                "plan" => {
                  "interval" => "month",
                  "name" => "MyFlix Basic",
                  "created" => 1414524533,
                  "amount" => 1000,
                  "currency" => "usd",
                  "id" => "myflix_basic",
                  "object" => "plan",
                  "livemode" => false,
                  "interval_count" => 1,
                  "trial_period_days" => 30,
                  "metadata" => {
                  },
                  "statement_description" => "MyFlix Basic"
                },
                "description" => nil,
                "metadata" => {
                }
              }
            ]
          },
          "subtotal" => 0,
          "total" => 0,
          "customer" => "cus_537skIMkMhOBt9",
          "object" => "invoice",
          "attempted" => true,
          "closed" => true,
          "forgiven" => false,
          "paid" => true,
          "livemode" => false,
          "attempt_count" => 0,
          "amount_due" => 0,
          "currency" => "usd",
          "starting_balance" => 0,
          "ending_balance" => 0,
          "next_payment_attempt" => nil,
          "webhooks_delivered_at" => nil,
          "charge" => nil,
          "discount" => nil,
          "application_fee" => nil,
          "subscription" => "sub_537ss6olixdgsQ",
          "metadata" => {
          },
          "statement_description" => nil,
          "description" => nil,
          "receipt_number" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_537sbk4HctP7FI"
    }
  end

  let(:subject_user) { Fabricate(:user, customer_token: 'cus_537skIMkMhOBt9') }

  before :each do

    post '/stripe_events', event_data
  end

  it 'creates a payment with the webhook from stripe for charge succeeded' do
    expect(Payment.count).to eq(1)
  end

  it 'creates a payment associated with the correct user' do
    expect(Payment.first.user).to eq(subject_user)
  end

  it 'creates a payment of the correct amount' do
    expect(Payment.first.amount).to eq(999)
  end
end
