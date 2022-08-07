class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :client
      t.belongs_to :portfolio
      t.string :canonical_id
      t.string :name

      t.timestamps
    end
  end
end
