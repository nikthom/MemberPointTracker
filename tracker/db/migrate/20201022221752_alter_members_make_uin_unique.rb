class AlterMembersMakeUinUnique < ActiveRecord::Migration[6.0]
  def change
    change_column :members, :uin, :integer, unique: true
  end
end
