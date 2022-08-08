class AddPlantsToPlot < ActiveRecord::Migration[5.2]
  def change
    add_reference :plots, :plot, foreign_key: true
  end
end
