class CreatePointEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :point_entries do |t|
      t.integer 'UIN'
      t.string 'comment'
      t.integer 'officerId'
      t.timestamps
    end
  end
end
