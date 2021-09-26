class MARC::Record::Field
  include ActiveModel::Embedding::Document

  attribute :tag, :string
  attribute :indicator1, :string, default: ""
  attribute :indicator2, :string, default: ""
  attribute :value, :string, default: ""

  embeds_many :subfields, collection: "SubfieldCollection"

  delegate :occurences, :[], :repeated?, :to_h, to: :subfields

  def attributes
    if control_field?
      {
        "id": id,
        "tag": tag,
        "value": value
      }
    else
      {
        "id": id,
        "tag": tag,
        "indicator1": indicator1,
        "indicator2": indicator2,
        "subfields": subfields,
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
