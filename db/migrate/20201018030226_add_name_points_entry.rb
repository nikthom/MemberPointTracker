class AddNamePointsEntry < ActiveRecord::Migration[6.0]
  def change
        add_column("point_entries","name", :string)
  end
end
