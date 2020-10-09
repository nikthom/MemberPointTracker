class CreateAttendanceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_entries do |t|
      t.integer 'UIN'
      t.integer 'eventId'
      t.timestamps
    end
  end
end
