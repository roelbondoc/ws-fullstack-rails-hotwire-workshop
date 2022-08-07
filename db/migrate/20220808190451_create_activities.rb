class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.belongs_to :account
      t.belongs_to :security
      t.string :activity_type
      t.numeric :amount
      t.datetime :posted_at
      t.datetime :effective_on

      t.timestamps
    end
  end
end
