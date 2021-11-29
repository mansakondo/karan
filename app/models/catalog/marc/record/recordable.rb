module Catalog
  module MARC::Record::Recordable
    extend ActiveSupport::Concern

    included do
      has_one :marc_record,
        class_name: "Catalog::MARC::Record",
        as: :marc_recordable,
        touch: true

      delegate :format, to: :marc_record

      validates_associated :marc_record

      def process
        processor.process(marc_record)
      end

      def index(field_or_fields, collection: false)
        indexer.index(marc_record, field_or_fields, collection: collection)
      end

      def processor
        "#{namespace}::Processor".constantize
      end

      def indexer
        "#{namespace}::Indexer".constantize
      end

      def validator
        "#{namespace}::Validator".constantize
      end

      def namespace
        "#{self.class}::#{format.upcase}"
      end
    end
  end
end
