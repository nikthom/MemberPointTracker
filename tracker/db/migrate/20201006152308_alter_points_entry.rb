class AlterPointsEntry < ActiveRecord::Migration[6.0]
  def change
    rename_column('point_entries', 'UIN', 'uin')
    add_column('point_entries', 'points_add', :integer)
    add_column('point_entries', 'points_remove', :integer)
  end
end
