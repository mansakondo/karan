module Catalog
  class MARC::Record::Field
    include ActiveModel::Embedding::Document

    attribute :tag, :string
    attribute :indicator1, :string, default: "#"
    attribute :indicator2, :string, default: "#"
    attribute :value, :string, default: ""

    embeds_many :subfields, collection: "SubfieldCollection"

    validates :tag, presence: true, format: { with: /\d{3}/ }
    validates_associated :subfields, unless: :control_field?

    delegate :[], :at, :to_h, :repeated?, :occurrences, to: :subfields

    def attributes
      if control_field?
        {
          "id" => id,
          "tag" => tag,
          "value" => value
        }
      else
        {
          "id" => id,
          "tag" => tag,
          "indicator1" => indicator1,
          "indicator2" => indicator2,
          "subfields" => subfields
        }
      end
    end

    def control_field?
      /00\d/ === tag
    end

    def main_attribute
      tag
    end
  end
end
