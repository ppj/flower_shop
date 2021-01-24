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

    package = []

    while bundles.any?
      remainder = quantity - package.sum

      bundles.each do |bundle_size|
        count, remainder = remainder.divmod(bundle_size)
        count.times { package << bundle_size }
      end

      if package_incomplete?(package, quantity)
        removed_available_bundle_size = bundles.shift
        removed_bundle_size_from_package = package.pop

        until removed_bundle_size_from_package == removed_available_bundle_size || package.empty?
          # Remove packaged bundles until the last remaining packaged bundle size
          # is the same as the one that will not be considered for packaging any more,
          # or there is no more available bundle size remaining
          removed_bundle_size_from_package = package.pop
        end
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
