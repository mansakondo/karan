module Catalog
  module MARC::Indexing
    extend ActiveSupport::Concern

    included do
      include MARC::Processing

      alias_method :index, :process
      alias_method :index_each, :process_each

      def entry_index(field)
        if field.respond_to? :value
          field.value
        else
          field.at("a").value
        end
      end
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

