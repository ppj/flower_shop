# frozen_string_literal: true

class PrettyPrinter
  def self.print(product_code:, package:)
    new(product_code, package).print
  end

  def initialize(product_code, package)
    @product_code = product_code
    @package = package
  end

  def print
    output = [ order_line(total_quantity, product_code, total_price) ]

    package.map do |size, num|
      output << order_line(num, size, price_for_size(size), indentation: true)
    end

    output.join("\n")
  end

  private

  attr_reader :product_code, :package

  def total_price
    package.map { |size, num| num * price_for_size(size) }.sum
  end

  def total_quantity
    package.map { |size, num| size * num }.sum
  end

  def price_for_size(size)
    available_bundles_with_prices[size]
  end

  def available_bundles_with_prices
    @available_bundles_with_prices ||= Catalogue.available_bundles_with_prices(product_code)
  end

  def order_line(quantity, code, price_in_cents, indentation: false)
    prefix = indentation ? "\t" : ""

    "#{prefix}#{quantity} x #{code} $#{display_price(price_in_cents)}"
  end

  def display_price(price_in_cents)
    format("%0.2f", price_in_cents/100.0)
  end
end
