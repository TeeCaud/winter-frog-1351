class Garden < ApplicationRecord
  has_many :plots

  def less_than_100
    plots.joins(:plants).where("days_to_harvest < 100").pluck(:name).uniq
  end
end
