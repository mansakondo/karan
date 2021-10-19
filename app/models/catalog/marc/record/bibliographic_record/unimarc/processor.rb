module Catalog
  class MARC::Record::BibliographicRecord < ApplicationRecord
    class UNIMARC::Processor
      include MARC::Processing

      def resolve_links_in(field)
        links = field.occurrences("3")

        links.filter_map do |link|
          id = link.value

          query = search do
            query do
              regexp "fields.value" do
                value ".*(#{id}).*"
              end
            end
          end

          response = MARC::Record.search query

          response.records.first
        end
      end

      def on_200(field)
        field.at("a").value
      end

      def on_6xx(field)
        targets = resolve_links_in field

        targets.each do |target|
          subjects = record.subjects

          subjects.add(target) unless subjects.include? target
        end

        field.as_json
      end

      alias on_600 on_6xx
      alias on_601 on_6xx
      alias on_602 on_6xx
      alias on_604 on_6xx
      alias on_605 on_6xx
      alias on_606 on_6xx
      alias on_607 on_6xx
      alias on_616 on_6xx
      alias on_617 on_6xx
      alias on_623 on_6xx
      alias on_631 on_6xx
      alias on_632 on_6xx
      alias on_651 on_6xx
      alias on_660 on_6xx
      alias on_661 on_6xx
      alias on_670 on_6xx
      alias on_675 on_6xx
      alias on_676 on_6xx
      alias on_680 on_6xx

      def on_7xx(field)
        targets = resolve_links_in field

        targets.each do |target|
          contributors = record.contributors

          contributors.add(target) unless contributors.include? target
        end

        field.as_json
      end

      alias on_700 on_7xx
      alias on_701 on_7xx
      alias on_702 on_7xx
      alias on_710 on_7xx
      alias on_711 on_7xx
      alias on_712 on_7xx
      alias on_713 on_7xx
      alias on_716 on_7xx
      alias on_720 on_7xx
      alias on_721 on_7xx
      alias on_722 on_7xx
      alias on_723 on_7xx
      alias on_730 on_7xx
    end
  end
end
