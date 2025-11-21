class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.boolean :email_notifications_enabled
      t.boolean :in_app_notifications_enabled
      t.boolean :high_priority_notifications_only

      t.timestamps
    end
  end
end
