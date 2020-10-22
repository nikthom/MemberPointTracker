class AddForeignKeyAttendance < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :attendance_entries, :events, column: :eventId
  end
end
