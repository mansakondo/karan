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

      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def mappings
          MAPPINGS[format]
        end
      CODE

      def process
        processor.process(marc_record)
      end

      def processor
        "#{namespace}::Processor".constantize
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
