class AddMARCRecordableToCatalogMARCRecords < ActiveRecord::Migration[7.0]
  def change
    add_reference :catalog_marc_records, :marc_recordable, polymorphic: true, null: false
  end
end
