module Catalog
  module MARC::Record::Indexing
    extend ActiveSupport::Concern

    included do
      delegate :mappings, to: :marc_recordable

      def as_indexed_json(options = {})
        if (indexes = mappings.try(:keys))
          as_json(methods: indexes)
        else
          as_json
        end
      end

      def method_missing(name, *args, &block)
        return super unless mappings.try(:has_key?, name)

        define_index name

        public_send name
      end

      private

      def define_index(index)
        klass = self.class

        klass.class_eval do
          define_method index do
            tag, code = mappings[index]

            return unless (field = at tag)

            field[code].value
          end

          define_method "#{index}=" do |value|
            tag, code = mappings[index]

            return unless (field = at tag)

            field[code].value = value
          end
        end
      end
    end
  end
end
