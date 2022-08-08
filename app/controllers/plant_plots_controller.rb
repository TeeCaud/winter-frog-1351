class PlantPlotsController < ApplicationController

  def destroy
    PlantPlot.find(params[:id]).destroy
    redirect_to "/plots"
  end
end
