require 'rails_helper'

RSpec.describe 'plots index' do
  it 'has a list of plot numbers, with the names of all of their plots' do
    garden1 = Garden.create!(name: "My Garden", organic: true)
    garden2 = Garden.create!(name: "Not My Garden", organic: false)

    plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden_id: garden1.id)
    plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden_id: garden1.id)
    plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden_id: garden1.id)
    plot4 = Plot.create!(number: 4, size: "Extra Large", direction: "West", garden_id: garden2.id)

    plant1 = Plant.create!(name: "Marigold", description: "American Marigold", days_to_harvest: 45)
    plant2 = Plant.create!(name: "Vinca", description: "Apocynceae", days_to_harvest: 50)
    plant3 = Plant.create!(name: "Beautybush", description: "Beautiful", days_to_harvest: 55)
    plant4 = Plant.create!(name: "Fountain Grass", description: "Poacaea", days_to_harvest: 60)

    plotplant1 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant1.id)
    plotplant2 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant2.id)
    plotplant3 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant3.id)
    plotplant4 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant2.id)
    plotplant5 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant4.id)

    visit '/plots'
    expect(current_path).to eq('/plots')
    within "#plot-#{plot1.number}" do
      expect(page).to have_content("Plot: 1")
      expect(page).to have_content("Marigold")
      expect(page).to have_content("Vinca")
      expect(page).to have_content("Beautybush")
      expect(page).to_not have_content("Fountain Grass")
    end

    within "#plot-#{plot2.number}" do
      expect(page).to have_content("Plot: 2")
      expect(page).to_not have_content("Plot: 1")
      expect(page).to have_content("Vinca")
      expect(page).to have_content("Fountain Grass")
      expect(page).to_not have_content("Marigold")
    end
  end

  it 'can remove a plant from a plot' do
    garden1 = Garden.create!(name: "My Garden", organic: true)
    garden2 = Garden.create!(name: "Not My Garden", organic: false)

    plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden_id: garden1.id)
    plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden_id: garden1.id)
    plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden_id: garden1.id)
    plot4 = Plot.create!(number: 4, size: "Extra Large", direction: "West", garden_id: garden2.id)

    plant1 = Plant.create!(name: "Marigold", description: "American Marigold", days_to_harvest: 45)
    plant2 = Plant.create!(name: "Vinca", description: "Apocynceae", days_to_harvest: 50)
    plant3 = Plant.create!(name: "Beautybush", description: "Beautiful", days_to_harvest: 55)
    plant4 = Plant.create!(name: "Fountain Grass", description: "Poacaea", days_to_harvest: 60)

    plotplant1 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant1.id)
    plotplant2 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant2.id)
    plotplant3 = PlantPlot.create!(plot_id: plot1.id, plant_id: plant3.id)
    plotplant4 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant2.id)
    plotplant5 = PlantPlot.create!(plot_id: plot2.id, plant_id: plant4.id)

    visit '/plots'
# save_and_open_page
    within "#plot-#{plot1.number}" do
      expect(page).to have_link("Remove Marigold")
      expect(page).to have_link("Remove Vinca")
      expect(page).to_not have_link("Remove Fountain Grass")
      click_link("Remove Marigold")
      expect(current_path).to eq("/plots")
      expect(page).to_not have_content("Marigold")
    end
  end
end
