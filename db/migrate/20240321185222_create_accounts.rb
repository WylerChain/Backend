class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :email, null: false
      t.string :current_session_id

      t.timestamps

      t.index :email, unique: true
    end
  end
end
