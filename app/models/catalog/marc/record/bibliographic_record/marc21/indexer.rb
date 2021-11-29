module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class MARC21::Indexer
      include MARC::Indexing

      def on_245(field)
        title_proper = field.at("a").value

        title_proper
      end
    end
  end
end

