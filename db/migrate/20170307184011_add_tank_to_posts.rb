class AddTankToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :rank, :float
  end
end
