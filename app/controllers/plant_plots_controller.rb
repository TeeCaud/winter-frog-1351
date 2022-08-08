class PlantPlotsController < ApplicationController

  def destroy
    plot = Plot.find(params[:id])
    # plant = Plant.find(params[:id]).destroy

    # I am doing something wrong, but i think I am close =(. I can't get this to destroy)
    PlantPlot.where(plant_id: params[:plant_id], plot_id:params[:id])
    redirect_to "/plots"
  end
end
