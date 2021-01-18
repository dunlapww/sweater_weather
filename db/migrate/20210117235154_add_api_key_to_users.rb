class AddApiKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :api_key, :uuid, default: "gen_random_uuid()", null: false
  end
end
