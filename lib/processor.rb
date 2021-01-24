# frozen_string_literal: true

require_relative "./catalogue"
require_relative "./package_maker"
require_relative "./pretty_printer"

class Processor
  def self.process(order:)
    new(order).process
  end

  def initialize(order)
    @order = order
  end

  def process
    order_lines.map do |line|
      ordered_quantity, product_code = line.split.compact
      package = PackageMaker.make(
        ordered_quantity: ordered_quantity.to_i,
        available_bundle_sizes: bundles[product_code],
      )
      PrettyPrinter.print(product_code: product_code, package: package)
    end
  end

  private

  attr_reader :order

  def order_lines
    @order_lines ||= File.readlines(order).map(&:strip).compact
  end

  def bundles
    @bundles ||= Catalogue.bundles
  end
end
