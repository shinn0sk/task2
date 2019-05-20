class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 8,null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
