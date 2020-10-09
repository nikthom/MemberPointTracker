class CreateOfficers < ActiveRecord::Migration[5.1]
  def change
    create_table :officers do |t|
      t.string 'name'
      t.string 'email'
      t.string 'position'
      t.integer 'UIN'
      t.integer 'points'
      t.string 'password_digest'
      t.timestamps
    end
  end
end
