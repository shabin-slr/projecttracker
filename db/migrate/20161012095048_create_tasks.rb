class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string     :name,        null: false
      t.text       :description, null: false
      t.integer    :user_id,     null: false
      t.timestamps              null: false
    end
  end
end
