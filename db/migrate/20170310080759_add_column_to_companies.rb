class AddColumnToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :chief_id, :integer
  end
end
