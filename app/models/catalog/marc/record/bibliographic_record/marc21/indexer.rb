module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class MARC21::Indexer
      include MARC::Indexing

      def on_100(field)
        entry = field.at("a").value

        { entry: entry }
      end

      def on_245(field)
        title_proper       = field.at("a").value.gsub(" /", "")
        remainder_of_title = field.at("b").try(:value) || ""

        title_proper + " " + remainder_of_title.gsub(" /", "")
      end

      def on_650(field)
        multi_level_index field
      end

      def on_655(field)
        multi_level_index field
      end

      private

      def multi_level_index(field)
        entry        = field.at("a").value
        subfields    = field.subfields
        subdivisions = subfields.select do |subfield|
          %w( v x y z ).include? subfield.code
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

