class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer   :task_id
      t.string    :description
      t.date      :date
      t.integer   :hours_spent
      t.timestamps null: false
    end
  end
end
