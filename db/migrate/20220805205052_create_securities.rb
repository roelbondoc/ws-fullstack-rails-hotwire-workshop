class CreateSecurities < ActiveRecord::Migration[7.0]
  def change
    create_table :securities do |t|
      t.string :symbol
      t.numeric :buy_cost
      t.numeric :sell_cost
      t.numeric :value

      t.timestamps
    end
  end
end
