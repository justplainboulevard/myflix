
class CreateInvitations < ActiveRecord::Migration

  def change

    create_table :invitations do |t|
      t.integer :inviter_id
      t.string :invitee_name
      t.string :invitee_email_address
      t.text :invitation_message

      t.timestamps
    end
  end
end
