class CreateKlasses < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses do |t|
      t.string :name, null: false
      t.string :subject, null: false
      t.integer :level, null: false
      t.integer :credits, null: false
      t.timestamps
    end
  end
end
