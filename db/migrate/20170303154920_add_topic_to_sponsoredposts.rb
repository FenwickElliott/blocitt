class AddTopicToSponsoredposts < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsoredposts, :topic_id, :integer
    add_index :sponsoredposts, :topic_id
  end
end
