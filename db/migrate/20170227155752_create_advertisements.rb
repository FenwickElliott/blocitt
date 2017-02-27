class CreateAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.text :copy
      t.string :price
      t.string :integer

      t.timestamps
    end
  end
end
