module Catalog
  module MARC::Processing
    extend ActiveSupport::Concern

    included do
      include Processing
      include Elasticsearch::DSL

      def identify(field)
        field.tag
      end
    end

    class_methods do
      def process(record)
        processor = new(record)
        fields    = record.fields

        processor.process_each(fields)
      end
    end
  end
end
