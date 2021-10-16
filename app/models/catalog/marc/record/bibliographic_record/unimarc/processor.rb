module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class UNIMARC::Processor
      include MARC::Processing

      def on_200(field)
        field.at("a").value
      end
    end
  end
end
