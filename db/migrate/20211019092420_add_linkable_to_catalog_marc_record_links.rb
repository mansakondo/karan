class AddLinkableToCatalogMARCRecordLinks < ActiveRecord::Migration[7.0]
  def change
    add_reference :catalog_marc_record_links, :linkable, polymorphic: true, null: false
  end
end
