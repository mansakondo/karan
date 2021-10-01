module MARC::Enumerable
  include Enumerable

  def occurences(value)
    select { |e| e.main_attribute == value }
  end

  def [](value)
    matches = occurences(value)

    if matches.count == 1
      matches.first
    else
      matches
    end
  end

  def repeated?(value)
    occurences(value).count > 1
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

  def to_h
    index_by(&:main_attribute)
  end
end
