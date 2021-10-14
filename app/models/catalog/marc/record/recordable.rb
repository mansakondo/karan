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
    end
  end
end
