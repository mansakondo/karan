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

    delegated_type :marc_recordable,
      types: TYPES,
      inverse_of: :marc_record

    embeds_many :fields, collection: "FieldCollection"

    enum format: { marc21: 0, unimarc: 1 }

    validates :fields, presence: true
    validates_associated :fields

    validates :format, presence: true, inclusion: { in: MARC::FORMATS }

    delegate :at, :to_h, :repeated?, :occurrences, to: :fields

    def as_indexed_json(options = {})
      as_json(methods: :title)
    end
  end
end
