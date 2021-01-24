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

    while bundles.any?
      package = []
      remainder = quantity

      bundles.each do |bundle_size|
        count, remainder = remainder.divmod(bundle_size)
        count.times { package << bundle_size }
      end

      if package_incomplete?(package, quantity)
        bundles.shift
      else
        break
      end
    end

    return {} if package_incomplete?(package, quantity)

    package_grouped_by_sizes(package)
  end

  private

  attr_reader :quantity, :bundles

  def package_incomplete?(package, quantity)
    # Quantity in the package doesn't match the required quantity
    package.sum != quantity
  end

  def package_grouped_by_sizes(package)
    package.uniq.map { |size| [size, package.count(size)] }.to_h
  end
end
