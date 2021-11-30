module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class UNIMARC::Indexer
      include MARC::Indexing

      def on_200(field)
        title_proper = field.at("a").value

        title_proper
      end

      def on_606(field)
        multi_level_index field
      end

      def on_608(field)
        multi_level_index field
      end

      def on_700(field)
        last_name  = field.at("a").value
        first_name = field.at("b").try(:value) || ""
        entry      = last_name + ", " + first_name

        { entry: entry }
      end

      alias on_701 on_700

      private

      def multi_level_index(field)
        entry        = field.at("a").value
        subfields    = field.subfields
        subdivisions = subfields.select do |subfield|
          %w( j x y z ).include? subfield.code
        end

        level1, level2, level3, level4 = subdivisions.map(&:value).take(4)

        {
          entry: entry,
          level1: level1,
          level2: level2,
          level3: level3,
          level4: level4
        }
      end
    end
  end
end
