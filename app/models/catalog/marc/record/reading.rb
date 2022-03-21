module Catalog
  module MARC::Record::Reading
    extend ActiveSupport::Concern

    class_methods do
      def read(file = nil, marc: nil, record_type: :bibliographic, format:, encoding: "UTF-8", autosave: false, on_duplicate: "skip")
        reader =
          if file
            ::MARC::Reader.new(file, external_encoding: encoding)
          else
            ::MARC::Reader.new(StringIO.new(marc), external_encoding: encoding)
          end

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

          original_id = record.at("001").value

          duplicate_detection_query = Elasticsearch::DSL::Search.search do
            query do
              term "fields.value.keyword" => original_id
            end
          end

          response  = search duplicate_detection_query
          duplicate = response.records.first

          if duplicate
            case on_duplicate
            when "update"
              duplicate.assign_attributes(
                leader: record.leader,
                fields: record.fields
              )

              duplicate.save

              next
            else
              next
            end
          end

          if autosave == true
            record.fields.save
          end


          marc_recordables << marc_recordable
        end

        return marc_recordables.lazy, record_type_class
      end
    end
  end
end
