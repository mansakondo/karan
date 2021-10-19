class CreateCatalogMARCRecordLinkContributions < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_record_link_contributions do |t|

      t.timestamps
    end
  end
end
