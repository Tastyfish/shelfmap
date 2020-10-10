class AddExpToJwtBlacklist < ActiveRecord::Migration[6.0]
  def change
    change_table :jwt_blacklist do |t|
      t.datetime :exp, null: false
    end
  end
end
