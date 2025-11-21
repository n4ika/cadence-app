class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :client
      t.string :project_type
      t.date :start_date
      t.date :estimated_end_date
      t.date :actual_end_date
      t.references :user

      t.timestamps
    end
    add_foreign_key :projects, :users, column: :user_id
  end
end
