module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class MARC21::Processor
      include MARC::Processing

      def on_245(field)
        field.at("a").value
      end
    end
  end
end
