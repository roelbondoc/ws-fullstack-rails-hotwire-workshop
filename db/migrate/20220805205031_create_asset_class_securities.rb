class CreateAssetClassSecurities < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_class_securities do |t|
      t.belongs_to :asset_class
      t.belongs_to :security

      t.timestamps
    end
  end
end
