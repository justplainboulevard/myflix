
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#normalize_list_order' do

    set_user

    it 'normalizes the queue item position numbers' do
      Fabricate(:queue_item, user_id: user.id, list_order: 2)
      Fabricate(:queue_item, user_id: user.id, list_order: 3)
      user.normalize_list_order
      expect(user.queue_items.map(&:list_order)).to eq([1, 2])
    end
  end
end
