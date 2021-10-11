class CreateCatalogMARCRecordBibliographicRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_record_bibliographic_records do |t|

      t.timestamps
    end
  end
end
