module Catalog
  module MARC::Record::Reading
    extend ActiveSupport::Concern

    class_methods do
      def read(file, record_type: :bibliographic, format: "marc21", encoding: "UTF-8", autosave: false)
        reader = ::MARC::Reader.new(file, external_encoding: encoding)

        case record_type
        when :bibliographic
          record_type_class = MARC::Record::BibliographicRecord
        when :authority
          record_type_class = MARC::Record::AuthorityRecord
        end

        marc_recordables = []

        reader.each_raw do |raw|
          record          = new_from_marc(raw, encoding: encoding)
          marc_recordable = record_type_class.new

          record.format          = format
          record.marc_recordable = marc_recordable

          if autosave == true
            record.fields.save
          end

          marc_recordables << marc_recordable
        end

        return marc_recordables.lazy
      end
    end
  end
end
