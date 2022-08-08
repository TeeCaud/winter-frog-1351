require 'rails_helper'

RSpec.describe 'garden show page' do
  it 'has a list of unqiue plants that are included in the gardens plots, where they take less than 100 days to harvest' do
    garden1 = Garden.create!(name: "My Garden", organic: true)
    garden2 = Garden.create!(name: "Not My Garden", organic: false)

    plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden_id: garden1.id)
    plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden_id: garden1.id)
    plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden_id: garden1.id)
    plot4 = Plot.create!(number: 4, size: "Extra Large", direction: "West", garden_id: garden2.id)

    plant1 = Plant.create!(name: "Marigold", description: "American Marigold", days_to_harvest: 45)
    plant2 = Plant.create!(name: "Vinca", description: "Apocynceae", days_to_harvest: 50)
    plant3 = Plant.create!(name: "Beautybush", description: "Beautiful", days_to_harvest: 100)
    plant4 = Plant.create!(name: "Fountain Grass", description: "Poacaea", days_to_harvest: 200)

    plotplant1 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant1.id)
    plotplant2 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant2.id)
    plotplant3 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant3.id)
    plotplant4 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant2.id)
    plotplant5 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant4.id)

    visit "/gardens/#{garden1.id}"
save_and_open_page
    expect(page).to have_content("My Garden")
    expect(page).to_not have_content("Not My Garden")
    expect(page).to have_content([plant1.name, plant2.name])
  end
end
