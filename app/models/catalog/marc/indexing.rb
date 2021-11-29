module Catalog
  module MARC::Indexing
    extend ActiveSupport::Concern

    included do
      include MARC::Processing

      alias_method :index, :process
      alias_method :index_each, :process_each
    end

    class_methods do
      def index(record, field_or_fields, collection: false)
        indexer = new(record)

        if collection
          fields = field_or_fields

          indexer.index_each(fields)
        else
          field = field_or_fields

          indexer.index(field)
        end
      end
    end
  end
end

