# frozen_string_literal: true

class PrettyPrinter
  def self.print(product_code:, package:)
    puts new(product_code, package).print
  end

  def initialize(product_code, package)
    @product_code = product_code
    @package = package
  end

  def print
    total_price = package.map do |size, num|
      num * available_bundles[size]
    end.sum

    total_quantity = package.map do |size, num|
      size * num
    end.sum

    output = [ "#{total_quantity} x #{product_code} $#{format("%0.2f", total_price/100.0)}" ]
      package.map do |size, num|
        output << "\t#{num} x #{size} $#{format("%0.2f", num * available_bundles[size]/100.0)}"
      end

    output.join("\n")
  end

  private

  attr_reader :product_code, :package

  def available_bundles
    @available_bundles ||= Catalogue.bundles[product_code]
  end
end
