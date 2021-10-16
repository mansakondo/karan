module Catalog
  class MARC::Record::AuthorityRecord < ApplicationRecord
    include MARC::Record::Recordable
  end
end
