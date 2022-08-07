class CreateAllocations < ActiveRecord::Migration[7.0]
  def change
    create_table :allocations do |t|
      t.belongs_to :portfolio
      t.belongs_to :asset_class
      t.numeric :amount

      t.timestamps
    end
  end
end
