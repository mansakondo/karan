module Catalog
  module MARC::Record::Reading
    extend ActiveSupport::Concern

    class_methods do
      def read(file, record_type: :bibliographic, format: "marc21", encoding: "UTF-8", autosave: false)
        reader = ::MARC::Reader.new(file, external_encoding: encoding)

        marc_recordables = []

        reader.each_raw do |raw|
          record = new_from_marc(raw, encoding: encoding)

          record.format = format

          case record_type
          when :bibliographic
            marc_recordable        = MARC::Record::BibliographicRecord.new
            record.marc_recordable = marc_recordable
          when :authority
            marc_recordable        = MARC::Record::AuthorityRecord.new
            record.marc_recordable = marc_recordable
          end

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
