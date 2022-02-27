module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    INDEXES = {
      "marc21" => {
        title: "245",
        subjects: ["650", { collection: true }],
        genre: "655",
        authors: [%w( 100 700 ), { collection: true }]
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
