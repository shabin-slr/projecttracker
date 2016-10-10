class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.decimal :time_taken
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
