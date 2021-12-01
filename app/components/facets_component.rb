# frozen_string_literal: true

class FacetsComponent < ViewComponent::Base
  attr_reader :aggregations

  def initialize(aggregations:)
    @aggregations = aggregations
  end
end
