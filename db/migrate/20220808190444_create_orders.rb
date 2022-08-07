class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :account
      t.belongs_to :security
      t.string :order_type
      t.numeric :amount
      t.datetime :posted_at
      t.datetime :rejected_at
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
