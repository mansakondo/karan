module Catalog
  module MARC::Record::Link::Linkable
    extend ActiveSupport::Concern

    included do
      has_one :link,
        class_name: "Catalog::MARC::Record::Link",
        as: :linkable,
        touch: true
    end
  end
end
