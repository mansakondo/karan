module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    MAPPINGS = {
      "marc21" => {
        title: ["245", "a"]
      },
      "unimarc" => {
        title: ["200", "a"]
      }
    }

    include MARC::Record::Recordable
  end
end
