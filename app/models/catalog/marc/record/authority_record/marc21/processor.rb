module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    class MARC21::Processor
      include MARC::Processing
    end
  end
end
