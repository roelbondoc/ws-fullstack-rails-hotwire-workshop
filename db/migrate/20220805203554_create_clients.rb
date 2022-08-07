class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postal
      t.string :province
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
