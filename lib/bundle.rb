# frozen_string_literal: true

class Bundle
  def initialize(product_code:, size:, cost:)
    @product_code = product_code
    @size = size
    @cost = cost
  end
end
