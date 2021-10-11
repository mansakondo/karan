module Catalog
  module MARC::Record::Creation
    extend ActiveSupport::Concern

    class_methods do
      def hash_from_marc(marc, encoding: "UTF-8")
        record = ::MARC::Reader.decode(
          marc,
          external_encoding: encoding,
          validate_encoding: true,
          invalid: :replace
        )

        leader = record.leader
        fields = record.fields

        fields_attributes = fields.map do |field|
          tag = field.tag

          case field
          when ::MARC::ControlField
            { tag: tag, value: field.value }
          when ::MARC::DataField
            subfields = field.subfields.map do |subfield|
              { code: subfield.code, value: subfield.value }
            end

            {
              tag: tag,
              indicator1: field.indicator1,
              indicator2: field.indicator2,
              subfields: subfields
            }
          end
        end

        { leader: leader, fields: fields_attributes }
      end

      def new_from_marc(marc, encoding: "UTF-8")
        attributes = hash_from_marc(marc, encoding: encoding)

        new(attributes)
      end
    end
  end
end
