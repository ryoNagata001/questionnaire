class AddReleaseToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :release, :boolean, default: false
  end
end
