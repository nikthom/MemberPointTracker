class AlterMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column('members', 'UIN', 'uin')
  end
end
