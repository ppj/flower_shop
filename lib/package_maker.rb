# frozen_string_literal: true

class PackageMaker
  def self.make(quantity:, available_bundle_sizes:)
    new(quantity, available_bundle_sizes).make
  end

  def initialize(quantity, available_bundle_sizes)
    @quantity = quantity
    @available_bundle_sizes = available_bundle_sizes.sort.reverse
  end

  def make
    return {} if quantity < available_bundle_sizes.last

    package = []

    while available_bundle_sizes.any?
      remainder = quantity - package.sum

      available_bundle_sizes.each do |bundle_size|
        count, remainder = remainder.divmod(bundle_size)
        count.times { package << bundle_size }
      end

      if package_incomplete?(package, quantity)
        removed_available_bundle_size = available_bundle_sizes.shift
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

  attr_reader :quantity, :available_bundle_sizes

  def package_incomplete?(package, quantity)
    # Quantity in the package doesn't match the required quantity
    package.sum != quantity
  end

  def package_grouped_by_sizes(package)
    package.uniq.map { |size| [size, package.count(size)] }.to_h
  end
end
