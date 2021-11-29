module Catalog
  class MARC::Record < ApplicationRecord
    TYPES = %w(
      Catalog::MARC::Record::BibliographicRecord
      Catalog::MARC::Record::AuthorityRecord
    ).freeze

    include ActiveModel::Embedding::Associations
    include Searchable
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

    has_many :subject_links, -> { merge(MARC::Record::Link.subjects).extending LinkExtension },
      through: :dependencies,
      source: :parent

    has_many :object_links, -> { merge(MARC::Record::Link.subjects).extending LinkExtension },
      through: :references,
      source: :child

    has_many :contributor_links, -> { merge(MARC::Record::Link.contributions).extending LinkExtension },
      through: :dependencies,
      source: :parent

    has_many :contribution_links, -> { merge(MARC::Record::Link.contributions).extending LinkExtension },
      through: :references,
      source: :child

    embeds_many :fields, collection: "FieldCollection"

    enum format: { marc21: 0, unimarc: 1 }

    validates :fields, presence: true
    validates_associated :fields

    validates :format, presence: true, inclusion: { in: MARC::FORMATS }

    delegate :at, :to_h, :repeated?, :occurrences, to: :fields
    delegate :process, :index, to: :marc_recordable

    class << self
      alias bibliographic catalog_marc_record_bibliographic_records
      alias authority catalog_marc_record_authority_records
    end

    scope :marc21_bibliographic, -> { marc21.merge(catalog_marc_record_bibliographic_records) }
    scope :marc21_authority, -> { marc21.merge(catalog_marc_record_authority_records) }
    scope :unimarc_bibliographic, -> { unimarc.merge(catalog_marc_record_bibliographic_records) }
    scope :unimarc_authority, -> { unimarc.merge(catalog_marc_record_authority_records) }
  end
end

module LinkExtension
  def add(*records)
    owner            = proxy_association.owner
    reflection       = proxy_association.reflection
    through          = reflection.options[:through]
    association_name = reflection.name
    reference        = owner.public_send(association_name).references_values.first
    where_values     = owner.public_send(association_name).where_values_hash(reference)
    linkable_class   = where_values["linkable_type"].constantize

    records.flatten.each do |record|
      owner.public_send(through).create!(
        parent: record,
        linkable: linkable_class.new
      )
    end

    load_target
  end
end
