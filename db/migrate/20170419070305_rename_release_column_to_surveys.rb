class RenameReleaseColumnToSurveys < ActiveRecord::Migration[5.0]
  def change
    rename_column :surveys, :release, :released
  end
end
