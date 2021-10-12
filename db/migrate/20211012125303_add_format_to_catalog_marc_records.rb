class AddFormatToCatalogMARCRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :catalog_marc_records, :format, :integer, null: false, default: 0
  end
end
