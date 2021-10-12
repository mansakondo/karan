module Catalog
  class MARC::Record::FieldCollection
    include MARC::Enumerable
    include ActiveModel::Embedding::Collecting
  end
end
