module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class UNIMARC::Validator
      include MARC::Validation
    end
  end
end
