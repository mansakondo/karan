class CreateCatalogMARCRecordLinkSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_record_link_subjects do |t|

      t.timestamps
    end
  end
end
