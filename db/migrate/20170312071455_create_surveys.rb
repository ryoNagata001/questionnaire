class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
