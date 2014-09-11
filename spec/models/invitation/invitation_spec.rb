
require 'rails_helper'

RSpec.describe Invitation, type: :model do

  it { should belong_to(:inviter) }

  it { should validate_presence_of(:invitee_name) }
  it { should validate_presence_of(:invitee_email_address) }
  it { should validate_presence_of(:invitation_message) }

  it_behaves_like 'is tokenable' do
    let(:object) { Fabricate(:invitation) }
  end
end
