module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    class UNIMARC::Validator
      include MARC::Validation
    end
  end
end
