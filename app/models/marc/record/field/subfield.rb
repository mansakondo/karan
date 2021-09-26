class MARC::Record::Field::Subfield
  include ActiveModel::Embedding::Document

  attribute :code, :string
  attribute :value, :string, default: ""

  def main_attribute
    code
  end
end
