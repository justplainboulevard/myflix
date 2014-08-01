
require 'rails_helper'

RSpec.describe Review, type: :model do

  it { should belong_to(:author).with_foreign_key('user_id').class_name('User') }

end
