class CreateDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries do |t|
      t.text :ask
      t.text :answer

      t.timestamps
    end
  end
end
