module Catalog
  module MARC::Enumerable
    include Enumerable

    def [](value)
      occurrences(value).first
    end

    alias_method :at, :[]

    def repeated?(value)
      occurrences(value).count > 1
    end

    def occurrences(value)
      Array(to_h[value])
    end

    def to_h
      index_by(&:main_attribute)
    end

    def index_by
      each_with_object({}) do |element, indexes|
        index = yield element

        if indexes[index]
          indexes[index] = Array(indexes[index]) << element
        else
          indexes[index] = element
        end
      end
    end
  end
end
