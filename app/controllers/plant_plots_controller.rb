class PlantPlotsController < ApplicationController

  def destroy
    # binding.pry
    plant = Plant.find(params[:id]).destroy
    PlantPlot.where(plant_id: params[:plant_id], plot_id:params[:id])
    redirect_to "/plots"
  end
end
