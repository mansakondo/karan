class CreateMARCRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :catalog_marc_records do |t|
      t.string :leader
      t.jsonb :fields

      t.timestamps
    end
  end
end
