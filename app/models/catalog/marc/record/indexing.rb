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

        public_send name
      end

      private

      def define_index(index)
        klass = self.class

        klass.class_eval do
          define_method index do
            tag, code = indexes[index]

            return unless (field = at tag)

            field[code].value
          end

          define_method "#{index}=" do |value|
            tag, code = indexes[index]

            return unless (field = at tag)

            field[code].value = value
          end
        end
      end
    end
  end
end
