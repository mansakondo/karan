module Catalog
  class MARC::Record < ApplicationRecord
    include ActiveModel::Embedding::Associations
    include Elasticsearch::Model

    embeds_many :fields, collection: "FieldCollection"

    validates :fields, presence: true
    validates_associated :fields

    delegate :occurences, :[], :repeated?, :to_h, to: :fields
  end
end
