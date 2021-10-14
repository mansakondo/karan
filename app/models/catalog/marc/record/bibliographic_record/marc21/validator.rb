module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class MARC21::Validator
      include MARC::Validation
    end
  end
end

