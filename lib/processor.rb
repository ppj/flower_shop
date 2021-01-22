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
      quantity, product_code = line.split.compact
      package = PackageMaker.make(
        quantity: quantity.to_i,
        bundles: bundles[product_code]
      )
      PrettyPrinter.print(package)
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
