class AddResetPasswordFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :lines_users, :reset_digest, :string
    add_column :lines_users, :reset_sent_at, :datetime
  end
end
