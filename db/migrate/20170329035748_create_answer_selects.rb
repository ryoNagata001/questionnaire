class CreateAnswerSelects < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_selects do |t|
      t.references :choice, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
