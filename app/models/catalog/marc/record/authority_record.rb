module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    include MARC::Record::Recordable

    def mappings
      {}
    end
  end
end
