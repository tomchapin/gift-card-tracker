class CreateCardIssuers < ActiveRecord::Migration
  def change
    create_table :card_issuers do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :card_issuers, :name, unique: true
  end
end
