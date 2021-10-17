module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    include MARC::Record::Recordable

    def indexes
      {}
    end
  end
end
