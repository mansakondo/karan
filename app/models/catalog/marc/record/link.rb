module Catalog
  class MARC::Record::Link < ApplicationRecord
    TYPES = %w(
      Catalog::MARC::Record::Link::Subject
      Catalog::MARC::Record::Link::Contribution
    ).freeze

    belongs_to :child,
      class_name: "Catalog::MARC::Record",
      inverse_of: :dependencies

    belongs_to :parent,
      class_name: "Catalog::MARC::Record",
      inverse_of: :references

    delegated_type :linkable,
      types: TYPES,
      inverse_of: :link
  end
end
