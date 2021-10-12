module Catalog
  module MARC
    FORMATS = %w( marc21 unimarc ).freeze

    def self.table_name_prefix
      "marc_"
    end
  end
end
