module Catalog
  module MARC::Record::Reading
    extend ActiveSupport::Concern

    class_methods do
      def read(file, format: "marc21", encoding: "UTF-8")
        reader = ::MARC::Reader.new(file, external_encoding: encoding)

        records = []

        reader.each_raw do |raw|
          record = new_from_marc(raw, encoding: encoding)

          record.format = format

          record.run_callbacks(:save) { false }

          records << record
        end

        records.lazy
      end
    end
  end
end
