class ChangeUinCase < ActiveRecord::Migration[5.1]
  def change
    rename_column('attendance_entries', 'UIN', 'uin')
    rename_column('officers', 'UIN', 'uin')
  end
end
