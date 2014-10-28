
require 'rails_helper'

RSpec.describe StripeWrapper, type: :model do

  describe StripeWrapper::Charge do

    describe '.create', :vcr do

      let(:token) do
        Stripe::Token.create(
          :card => {
            :number => card_number,
            :exp_month => 10,
            :exp_year => 2015,
            :cvc => "314"
          },
        ).id
      end

      context 'with a valid card' do

        let(:card_number) { '4242424242424242' }

        let(:response) { StripeWrapper::Charge.create(
            amount: 999,
            card: token,
            description: 'A valid test charge.'
        )}

        it 'successfully makes a charge' do

          # expect(response.amount).to eq(999)
          # expect(response.currency).to eq('usd')
          # expect(response.description).to eq('A valid test charge.')
          expect(response).to be_successful
        end
      end

      context 'with an invalid card' do

        let(:card_number) { '4000000000000002' }

        let(:charge) do
          StripeWrapper::Charge.create(
            amount: 999,
            card: token,
            description: 'An invalid test charge.'
          )
        end

        it 'does not charge the card' do

          expect(charge).not_to be_successful
        end

        it 'contains an error message' do

          expect(charge.error_message).to eq('Your card was declined.')
        end
      end
    end
  end
end
