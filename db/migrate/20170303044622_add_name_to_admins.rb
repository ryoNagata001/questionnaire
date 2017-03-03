class AddNameToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :name, :string, null: false, default: "名前を登録してください"
  end
end
