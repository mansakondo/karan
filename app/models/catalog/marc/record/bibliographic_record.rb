module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    INDEXES = {
      "marc21" => {
        title: "245"
      },
      "unimarc" => {
        title: "200",
        genre: "608",
        subjects: ["606", { collection: true }],
        authors: [%w( 700 701 ), { collection: true }]
      }
    }

    include MARC::Record::Recordable

    def indexes
      INDEXES[format]
    end
  end
end
