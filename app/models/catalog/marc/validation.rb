module Catalog
  module MARC::Validation
    extend ActiveSupport::Concern

    included do
      include MARC::Processing
    end

    class_methods do
      def validate(record)
        process record
      end
    end
  end
end
