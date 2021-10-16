module Processing
  extend ActiveSupport::Concern

  included do
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def process(element)
      id         = identify element
      on_element = :"on_#{id}"

      if respond_to? on_element
        public_send(on_element, element)
      else
        handler_missing(element)
      end
    end

    def process_each(elements)
      elements.filter_map do |element|
        process element
      end
    end

    def handler_missing(element)
    end
  end
end
