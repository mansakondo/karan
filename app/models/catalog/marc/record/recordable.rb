module Catalog
  module MARC::Record::Recordable
    extend ActiveSupport::Concern

    class_methods do
      def short_name
        model_name.element
      end

      def plural_short_name
        model_name.element.pluralize
      end
    end

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

      def short_name
        self.class.short_name
      end

      def plural_short_name
        self.class.plural_short_name
      end
    end
  end
end
