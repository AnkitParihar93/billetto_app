class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :clerk_user_id
      t.string :email

      t.timestamps
    end
  end
end
