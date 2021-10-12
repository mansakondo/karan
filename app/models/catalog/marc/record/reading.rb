module Catalog
  module MARC::Record::Reading
    extend ActiveSupport::Concern

    class_methods do
      def read(file, record_type: :bibliographic, format: "marc21", encoding: "UTF-8", autosave: false)
        reader = ::MARC::Reader.new(file, external_encoding: encoding)

        records = []

        reader.each_raw do |raw|
          record = new_from_marc(raw, encoding: encoding)

          record.format = format

          case record_type
          when :bibliographic
            record.marc_recordable = MARC::Record::BibliographicRecord.new
          when :authority
            record.marc_recordable = MARC::Record::AuthorityRecord.new
          end

          if autosave == true
            record.run_callbacks(:save) { false }
          end

          records << record
        end

        records.lazy
      end
    end
  end
end
