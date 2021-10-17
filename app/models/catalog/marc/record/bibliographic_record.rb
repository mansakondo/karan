module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    INDEXES = {
      "marc21" => {
        title: ["245", "a"]
      },
      "unimarc" => {
        title: ["200", "a"]
      }
    }

    include MARC::Record::Recordable

    def indexes
      INDEXES[format]
    end
  end
end
