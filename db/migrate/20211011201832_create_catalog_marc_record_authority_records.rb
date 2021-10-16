class CreateCatalogMARCRecordAuthorityRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_record_authority_records do |t|
      t.string :entity_type

      t.timestamps
    end
  end
end
