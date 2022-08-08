class AddPlotToPlants < ActiveRecord::Migration[5.2]
  def change
    add_reference :plants, :plot, foreign_key: true
  end
end
