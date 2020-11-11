class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer "uin"
      t.integer "eventId"
      t.timestamps
    end
  end
end
