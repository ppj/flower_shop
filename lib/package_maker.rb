# frozen_string_literal: true

class PackageMaker
  def self.make(quantity:, bundles:)
    new(quantity, bundles).make
  end

  def initialize(quantity, bundles)
    @quantity = quantity
    @bundles = bundles.sort.reverse
  end

  def make
    return {} if quantity < bundles.last

    remainder = quantity
    package = bundles.map { |bundle_size|
      count, remainder = remainder.divmod(bundle_size)
      [bundle_size, count] if count.positive?
    }.compact.to_h

    if package_quantity(package) != quantity # Cannot create the package for the required quanity
      return {}
    end

    package
  end

  private

  attr_reader :quantity, :bundles

  def package_quantity(package)
    package.map { |bundle_size, count| bundle_size * count }.sum
  end
end
