class Subscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table "subscriptions" do |t|
      t.string "plan_id"
      t.integer "user_id"
      t.boolean "active", default: true
      t.datetime "current_period_ends_at"
      t.string "stripe_id"
    end
  end
end
