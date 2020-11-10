class AlterEvents < ActiveRecord::Migration[6.0]
  def change
    add_column("events","ptId", :integer)
  end
end
