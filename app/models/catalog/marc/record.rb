module Catalog
  class MARC::Record < ApplicationRecord
    include ActiveModel::Embedding::Associations
    include Elasticsearch::Model
    include ::Importing

    embeds_many :fields, collection: "FieldCollection"

    enum format: { marc21: 0, unimarc: 1 }

    validates :fields, presence: true
    validates_associated :fields

    delegate :occurences, :[], :repeated?, :to_h, to: :fields
  end
end
