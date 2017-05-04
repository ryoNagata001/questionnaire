class CreateUserSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :user_surveys do |t|
      t.references :user, foreign_key: true
      t.references :survey, foreign_key: true
      t.integer :question_number, default: 0

      t.timestamps
    end
  end
end
