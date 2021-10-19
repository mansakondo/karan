module Catalog
  class MARC::Record < ApplicationRecord
    TYPES = %w(
      Catalog::MARC::Record::BibliographicRecord
      Catalog::MARC::Record::AuthorityRecord
    ).freeze

    include ActiveModel::Embedding::Associations
    include Elasticsearch::Model
    include ::Importing

    include Creation
    include Reading
    include Indexing

    delegated_type :marc_recordable,
      types: TYPES,
      inverse_of: :marc_record

    has_many :dependencies,
      class_name: "Catalog::MARC::Record::Link",
      foreign_key: "child_id"

    has_many :references,
      class_name: "Catalog::MARC::Record::Link",
      foreign_key: "parent_id"

    has_many :parents, through: :dependencies

    has_many :children, through: :references

    has_many :subjects, -> { merge MARC::Record::Link.subjects },
      through: :dependencies,
      source: :parent

    has_many :objects, -> { merge MARC::Record::Link.subjects },
      through: :references,
      source: :child

    embeds_many :fields, collection: "FieldCollection"

    enum format: { marc21: 0, unimarc: 1 }

    validates :fields, presence: true
    validates_associated :fields

    validates :format, presence: true, inclusion: { in: MARC::FORMATS }

    delegate :at, :to_h, :repeated?, :occurrences, to: :fields
  end
end
