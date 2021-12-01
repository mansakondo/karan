# frozen_string_literal: true

class FacetComponent < ViewComponent::Base
  attr_reader :aggregation, :name

  def initialize(aggregation:, name:, root: true, root_entry: nil, root_field: nil)
    @name        = name
    @aggregation = aggregation
    @root        = root
    @root_entry  = root_entry
    @root_field  = root_field
  end

  def root?
    @root
  end

  def nested?
    entry
  end

  private

  def buckets
    aggregation.buckets
  end

  def entry
    aggregation.entry
  end

  def field
    metadata.field
  end

  def metadata
    aggregation.meta
  end

  def path
    metadata.path
  end

  def labelize(bucket)
    bucket[:key] + " (#{bucket[:doc_count]})"
  end

  def has_child?(bucket)
    child = bucket[:child]

    return false unless child && child.buckets.present?

    true
  end

  def fieldset_attributes
    unless root?
      { form: :search, "data-facet-component-target": "fieldset", disabled: true, class: fieldset_classes }
    else
      { form: :search }
    end
  end

  def fieldset_classes
    "hidden relative border-none"
  end
end
