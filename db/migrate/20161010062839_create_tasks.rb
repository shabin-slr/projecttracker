class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.decimal :time_taken

      t.timestamps null: false
    end
  end
end
