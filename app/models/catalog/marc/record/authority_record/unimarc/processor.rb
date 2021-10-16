module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    class UNIMARC::Processor
      include MARC::Processing
    end
  end
end
