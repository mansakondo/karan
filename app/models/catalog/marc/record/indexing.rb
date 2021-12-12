module Catalog
  module MARC::Record::Indexing
    extend ActiveSupport::Concern

    included do
      delegate :indexes, to: :marc_recordable

      def as_indexed_json(options = {})
        if indexes.present?
          as_json(options.merge!(methods: indexes.keys))
        else
          as_json(options)
        end
      end

      def method_missing(name, *args, &block)
        return super unless indexes.has_key?(name)

        define_index name

        public_send name if respond_to? name
      end

      private

      def define_index(name)
        tag_or_tags, options = indexes[name]

        collection = options.try(:fetch, :collection) || false

        if tag_or_tags.respond_to? :each
          tags = tag_or_tags

          define_composite_index name, tags, collection: collection
        else
          tag = tag_or_tags

          define_regular_index name, tag, collection: collection
        end
      end

      def define_regular_index(name, tag, collection: false)
        if collection
          fields = occurrences tag

          return unless fields.present?

          value = index fields, collection: true
        else
          field = at tag

          return unless field

          value = index field
        end

        define_index_method name, value
      end

      def define_composite_index(name, tags, collection: false)
        if collection
          fields = tags.map { |tag| occurrences tag }.flatten!
          value  = index fields, collection: true
        else
          fields = tags.map { |tag| at tag }
          value  = index(fields).join(" ")
        end

        define_index_method name, value
      end

      def define_index_method(name, value)
        value = value.gsub /\"/, "'" if value.is_a? String

        instance_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name}
            eval <<-STRING
              #{value.inspect}
            STRING
          end
        CODE
      end
    end
  end
end
