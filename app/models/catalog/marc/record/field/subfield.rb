module Catalog
  class MARC::Record::Field::Subfield
    include ActiveModel::Embedding::Document

    attribute :code, :string
    attribute :value, :string, default: ""

    validates :code, presence: true, format: { with: /\w/ }

    def main_attribute
      code
    end
  end
end
