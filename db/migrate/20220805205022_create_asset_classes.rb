class CreateAssetClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
