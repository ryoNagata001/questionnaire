class RenameChoisesToChoices < ActiveRecord::Migration[5.0]
  def change
    rename_table :choises, :choices
  end
end
