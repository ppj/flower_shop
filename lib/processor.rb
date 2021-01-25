# frozen_string_literal: true

require_relative "./catalogue"
require_relative "./package_maker"
require_relative "./pretty_printer"

class Processor
  def self.process(order_file:)
    new(order_file).process
  end

  def initialize(order_file)
    @order_file = order_file
  end

  def process
    output = order_lines.map do |line|
      ordered_quantity, product_code = line.split.compact
      package = PackageMaker.make(
        ordered_quantity: ordered_quantity.to_i,
        available_bundle_sizes: available_bundle_sizes(product_code),
      )
      PrettyPrinter.print(product_code: product_code, package: package)
    end

    output.join("\n")
  end

  private

  attr_reader :order_file

  def order_lines
    @order_lines ||= File.readlines(order_file).map(&:strip).compact
  end

  def available_bundle_sizes(product_code)
    Catalogue.available_bundle_sizes(product_code)
  end
end
