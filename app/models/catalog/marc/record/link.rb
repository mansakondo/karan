module Catalog
  class MARC::Record::Link < ApplicationRecord
    belongs_to :child,
      class_name: "Catalog::MARC::Record",
      inverse_of: :dependencies

    belongs_to :parent,
      class_name: "Catalog::MARC::Record",
      inverse_of: :references
  end
end
