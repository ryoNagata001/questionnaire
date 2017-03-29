class CreateAnswerTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_texts do |t|
      t.references :question, foreign_key: true
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
