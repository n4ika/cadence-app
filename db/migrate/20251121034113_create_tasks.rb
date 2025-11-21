class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.string :status
      t.references :project

      t.timestamps
    end
    add_foreign_key :tasks, :projects, column: :project_id
  end
end
