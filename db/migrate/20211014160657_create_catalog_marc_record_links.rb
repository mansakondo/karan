class CreateCatalogMARCRecordLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_record_links do |t|
      t.belongs_to :child, null: false, foreign_key: { to_table: :catalog_marc_records }
      t.belongs_to :parent, null: false, foreign_key: { to_table: :catalog_marc_records }

      t.timestamps
    end
  end
end
