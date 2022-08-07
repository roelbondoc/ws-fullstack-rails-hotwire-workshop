class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.belongs_to :account
      t.belongs_to :security
      t.numeric :quantity

      t.timestamps
    end
  end
end
