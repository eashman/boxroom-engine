class BoxroomAddColumnsMessageUserIdToShareLinks < ActiveRecord::Migration[5.0]
  def change
    add_column  :boxroom_share_links, :message, :text
    add_column  :boxroom_share_links, :user_id, :integer
  end
end
