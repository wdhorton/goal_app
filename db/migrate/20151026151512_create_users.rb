class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :session_token, null: false

      t.timestamps null: false
    end

    add_index :users, :session_token
  end
end