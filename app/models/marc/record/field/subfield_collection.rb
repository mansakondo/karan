class MARC::Record::Field
  class SubfieldCollection
    include MARC::Enumerable
    include ActiveModel::Embedding::Collecting
  end
end
