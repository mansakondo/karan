module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    class MARC21::Validator
      include MARC::Validation
    end
  end
end
