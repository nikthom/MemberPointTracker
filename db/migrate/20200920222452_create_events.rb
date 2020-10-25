class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date
      t.string "name"
      t.string "description"
      t.integer "pointsWorth"
      t.timestamps
    end
  end
end
