class MARC::Record < ApplicationRecord
  include ActiveModel::Embedding::Associations

  embeds_many :fields, collection: "FieldCollection"

  delegate :occurences, :[], :repeated?, :to_h, to: :fields
end
