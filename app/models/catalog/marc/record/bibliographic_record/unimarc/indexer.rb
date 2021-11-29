module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class UNIMARC::Indexer
      include MARC::Indexing

      def on_200(field)
        title_proper = field.at("a").value

        title_proper
      end

      def on_606(field)
        entry = field.at("a").value

        entry
      end

      def on_608(field)
        entry = field.at("a").value

        entry
      end

      def on_700(field)
        last_name  = field.at("a").value
        first_name = field.at("b").try(:value) || ""

        last_name + ", " + first_name
      end

      alias on_701 on_700
    end
  end
end
